//
//  ItemDetailView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 01/03/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: item.iconAsImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(item.examine)
            }
        }
        .navigationBarTitle(item.name)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetailView(item: PREVIEW_ITEM)
        }
    }
}
