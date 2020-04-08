//
//  PrayersViewModel.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Combine

class PrayersViewModel: BaseViewModel<Prayer> {
    init() {
        super.init(endpoint: .prayers)
    }
}
