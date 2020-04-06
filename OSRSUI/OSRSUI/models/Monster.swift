//
//  Monster.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct Monster: Codable, Identifiable {
    let id: String
    let name: String
    let combat_level: Int
    let hitpoints: Int
    let size: Int
    let attack_speed: Int
    let max_hit: Int
    let examine: String
}
