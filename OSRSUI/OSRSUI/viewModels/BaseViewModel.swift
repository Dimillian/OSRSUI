//
//  BaseViewModel.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine

class BaseViewModel<T: Codable & Identifiable>: ObservableObject {
    @Published var objects: [T] = []
    @Published var searchText = ""
    
    var endpoint: APIService.Endpoint {
        didSet {
            page = 1
            objects = []
            fetch()
        }
    }
    
    var page = 1
    
    private var currentObjects: [T] = [] {
        didSet {
            if page == 1 {
                objects = currentObjects
            } else {
                objects.append(contentsOf: currentObjects)
            }
        }
    }
    
    private var searchParam: [String: String]? {
        didSet {
            page = 1
            objects = []
            fetch()
        }
    }
    
    private var apiPublisher: AnyPublisher<ArrayResponse<T>, Never>?
    private var searchCancellable: AnyCancellable?
    private var apiCancellable: AnyCancellable? {
        willSet {
            apiCancellable?.cancel()
        }
    }
    private let itemsPerPage = 25
    
    
    init(endpoint: APIService.Endpoint) {
        self.endpoint = endpoint
        
        searchCancellable = _searchText
            .projectedValue
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
        guard objects.count == page * itemsPerPage else {
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
        apiPublisher = APIService.fetch(endpoint: endpoint,
                                        params: params)
            .replaceError(with: ArrayResponse(_items: []))
            .eraseToAnyPublisher()
        apiCancellable = apiPublisher?
            .map{ $0._items }
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentObjects, on: self)
    }
}


