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
    enum Filter: String, CaseIterable {
        case all = "All items"
        case equipment = "Equipment"
        case weapons = "Weapons"
        
        func endpoint() -> APIService.Endpoint {
            switch self {
            case .all: return .items
            case .equipment: return .equipment
            case .weapons: return .weapons
            }
        }
    }
    
    @Published var items: [Item] = []
    @Published var searchText = ""
    
    var page = 1
    var filter = Filter.all {
        didSet {
            page = 1
            items = []
            fetch()
        }
    }
    
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
    
    private var searchParam: [String: String]? {
        didSet {
            page = 1
            items = []
            fetch()
        }
    }
    
    private var apiPublisher: AnyPublisher<ItemResponse, Never>?
    private var searchCancellable: AnyCancellable?
    private var apiCancellable: AnyCancellable?
    private let itemsPerPage = 25
    
    
    init() {
        searchCancellable = $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] string in
                if string.isEmpty {
                    self?.searchParam = nil
                } else {
                    self?.searchParam = ["where": "{\"name\":\"\(string)\"}"]
                }
        }
    }
    
    func fetchNextPage() {
        guard items.count == page * itemsPerPage else {
            return
        }
        page += 1
        fetch()
    }
    
    func fetch() {
        var params: [String: String] = ["page": String(page)]
        if let searchParam = searchParam {
            params = params.merging(searchParam) { (current, _) in current }
        }
        apiPublisher = APIService.fetch(endpoint: filter.endpoint(),
                                     params: params)
            .replaceError(with: ItemResponse(_items: []))
            .eraseToAnyPublisher()
        apiCancellable = apiPublisher?
            .map{ $0._items }
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentItems, on: self)
    }
}
