//
//  HomeView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct ItemsView: View {
    
    @ObservedObject var viewModel = ItemsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                HStack {
                    Image(uiImage: item.iconAsImage)
                    Text(item.name)
                }
            }
            if !self.viewModel.items.isEmpty {
                Text("Loading next page...")
                    .onAppear {
                        self.viewModel.fetchNextPage()
                }
            }
        }.onAppear {
            self.viewModel.fetch()
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
