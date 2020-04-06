//
//  MonstersViewModel.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine

class MonstersViewModel: BaseViewModel<Monster> {
    init() {
        super.init(endpoint: .monsters)
    }
}
