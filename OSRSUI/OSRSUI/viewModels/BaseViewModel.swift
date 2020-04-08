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
    
    var canLoadMorePages: Bool {
        return objects.count < totalResults
    }
    
    private var currentMeta = ArrayResponse<T>.Meta(page: 0, max_results: 0, total: 0) {
        didSet {
            page = currentMeta.page
            totalResults = currentMeta.total
        }
    }
    
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
    
    private var totalResults = 26
    
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
        guard canLoadMorePages else {
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
            .replaceError(with: ArrayResponse(_items: [], _meta: ArrayResponse.Meta(page: 0,
                                                                                    max_results: 0,
                                                                                    total: 0)))
            .eraseToAnyPublisher()
        apiCancellable = apiPublisher?
            .receive(on: DispatchQueue.main)
            .sink(receiveValue:  { [weak self] response in
                self?.currentObjects = response._items
                self?.currentMeta = response._meta
            })
    }
}


