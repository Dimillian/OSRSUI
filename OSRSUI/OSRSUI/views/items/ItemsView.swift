//
//  HomeView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct ItemsView: View {
    
    @ObservedObject private var viewModel = ItemsViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                TextField("Search an item", text: $searchText)
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        ItemRow(item: item)
                    }
                }
                if !self.viewModel.items.isEmpty {
                    Text("Loading next page...")
                        .onAppear {
                            self.viewModel.fetchNextPage()
                    }
                }
            }.navigationBarTitle("Items")
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
