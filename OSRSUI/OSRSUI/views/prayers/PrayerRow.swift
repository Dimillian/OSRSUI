//
//  PrayerRow.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct PrayerRow: View {
    let prayer: Prayer
    
    var body: some View {
        HStack {
            Image(uiImage: prayer.icon.asImage)
            VStack(alignment: .leading, spacing: 4) {
                Text(prayer.name).font(.headline)
                Text(prayer.description).font(.subheadline)
            }
        }
    }
}
