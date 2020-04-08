//
//  HTTP.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation

struct ArrayResponse<T: Codable>: Codable {
    struct Meta: Codable {
        let page: Int
        let max_results: Int
        let total: Int
    }
    
    let _items: [T]
    let _meta: Meta
}
