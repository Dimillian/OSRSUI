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
    let examine: String
    
    let tradeable: Bool
    let stackable: Bool
    let cost: Int
    
    let wiki_url: URL
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

let PREVIEW_ITEM = Item(id: 0,
                        name: "preview item",
                        icon: "iVBORw0KGgoAAAANSUhEUgAAACQAAAAgCAYAAAB6kdqOAAABvUlEQVR4Xu2Xv26DMBDG4QEyZECKIkVCKIoyVR26dOrQpUOHDn3/V3F7nL7689kGAo6z9JNuiH1wP+6PIU3zr2Jq3bRVkQ/Y7feBvfcn93o8upfDwT11XQKwOGQMwfYx9O7rcnaf52GEezuFgNdfn4JQ7RjAQojZLAAMcPJbAOH73PcloBTIQiEAG8MB7Pt6MQ+wSW1QAs6Kh1A/NgtnHyKMcZMUCP3AIBw0XcqmgU9qb4W0JwTIwuRAYHETF4FSIMkORjn1xCnjayy8lN/vLVY7TglfvBRGTJpZrpXM+my1f6DhPRdJs8M3nAPibGDseY9hVgHxzbh3chC22dkPQ8EnufddpBgI69Lk3B8hnPrwOsPEw7FYqUzoOsqBUtps8XUASh0bYbxZxUCcJZzCNnjOBGgDDBRD8d4tQAVgRAqEs2jusLOGEhaCgTQTgApLp/s5A0RBGMg3shx2YZb0fZUz9issD4VpsR4PkJ+uYbczJQr94rW7KT3yDJcegLtqeuRlAFa+0bdoeuTxPV2538Ixt1D86Vutr8IR16CSndzfoSpQLIDh09dmscL5lJICMUClw3JKD8tGXiVgfgACr1tEhnw7UAAAAABJRU5ErkJggg==",
                        examine: "A sample item",
                        tradeable: true,
                        stackable: true,
                        cost: 1000,
                        wiki_url: URL(string: "https://oldschool.runescape.wiki/w/Abyssal_whip")!)
