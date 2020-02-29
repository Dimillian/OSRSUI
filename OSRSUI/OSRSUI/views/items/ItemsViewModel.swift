//
//  HomeViewModel.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Combine
import SwiftUI

class ItemsViewModel: ObservableObject {
    @Published var items: [Item] = []
    var page = 1
    
    private var currentItems: [Item] = [] {
        didSet {
            if page == 1 {
                items = currentItems
            } else {
                items.append(contentsOf: currentItems)
            }
        }
    }
    
    private struct ItemResponse: Codable {
        let _items: [Item]
    }
    
    private var publisher: AnyPublisher<ItemResponse, Never>?
    private var cancellable: AnyCancellable?
    private let itemsPerPage = 25
    
    // params example: "where": "{\"name\":\"dragon sword\"}"
    
    func fetchNextPage() {
        guard items.count == page * itemsPerPage else {
            return
        }
        page += 1
        fetch()
    }
    
    func fetch() {
        publisher = APIService.fetch(endpoint: .items, params: ["page": String(page)])
            .replaceError(with: ItemResponse(_items: []))
            .eraseToAnyPublisher()
        cancellable = publisher?
            .map{ $0._items }
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentItems, on: self)
    }
}
