//
//  ItemRow.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 01/03/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        HStack {
            Image(uiImage: item.icon.asImage)
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name).font(.headline)
                Text(item.examine).font(.subheadline)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: PREVIEW_ITEM)
    }
}
