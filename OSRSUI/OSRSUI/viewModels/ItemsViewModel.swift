//
//  HomeViewModel.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Combine
import SwiftUI

class ItemsViewModel: BaseViewModel<Item> {
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
    
    var filter = Filter.all {
        didSet {
            endpoint = filter.endpoint()
        }
    }
    
    init() {
        super.init(endpoint: filter.endpoint())
    }
}
  
