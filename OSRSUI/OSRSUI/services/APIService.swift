//
//  APIService.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import Combine

struct APIService {
    static let BASE_URL = URL(string: "https://api.osrsbox.com")!
    
    private static let decoder = JSONDecoder()
    
    enum Endpoint: String {
        case items, equipment, weapons, monsters, prayers
    }
    
    enum APIError: Error {
        case unknown
        case message(reason: String), parseError(reason: String), networkError(reason: String)
    }
    
    static func fetch<T: Codable>(endpoint: Endpoint,
                                  params: [String: String]? = nil) -> AnyPublisher<T ,APIError> {
        var component = URLComponents(url: BASE_URL.appendingPathComponent(endpoint.rawValue),
                                      resolvingAgainstBaseURL: false)!
        if let params = params {
            var queryItems: [URLQueryItem] = []
            for (_, value) in params.enumerated() {
                queryItems.append(URLQueryItem(name: value.key, value: value.value))
            }
            component.queryItems = queryItems
        }
        let request = URLRequest(url: component.url!)
        return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap{ data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }
            if (httpResponse.statusCode == 404) {
                throw APIError.message(reason: "Resource not found");
            }
            return data
        }
        .decode(type: T.self, decoder: APIService.decoder)
        .mapError{ APIError.parseError(reason: $0.localizedDescription) }
        .eraseToAnyPublisher()
    }
}
