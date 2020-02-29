//
//  Item.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct Item: Codable, Identifiable {
    let id: Int
    let name: String
    let icon: String
}

extension Item {
    var iconAsImage: UIImage {
        guard let data = Data(base64Encoded: icon),
            let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
