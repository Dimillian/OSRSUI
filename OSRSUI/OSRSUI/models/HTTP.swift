//
//  HTTP.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation

struct ArrayResponse<T: Codable>: Codable {
    let _items: [T]
}
