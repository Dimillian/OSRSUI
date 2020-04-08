//
//  Icon.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import UIKit


typealias Icon = String

extension Icon {
    var asImage: UIImage {
        guard let data = Data(base64Encoded: self),
            let image = UIImage(data: data) else {
                return UIImage()
        }
        return image
    }
}
