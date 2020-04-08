//
//  Prayer.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct Prayer: Codable, Identifiable {
    let id: String
    let name: String
    let icon: Icon
    let description: String
}
