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
    @State private var showFilterSheet = false
    
    private var filterButton: some View {
        Button(action: {
            self.showFilterSheet.toggle()
        }) {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.title)
        }
    }
    
    private var filterSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = []
        for filter in ItemsViewModel.Filter.allCases {
            buttons.append(.default(Text(filter.rawValue),
                                    action: {
                self.viewModel.filter = filter
            }))
        }
        buttons.append(.cancel())
        return ActionSheet(title: Text("Filter items"), buttons: buttons)
    }
    
    private var searchField: some View {
        HStack {
            TextField("Search an item", text: $viewModel.searchText)
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    self.viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.subheadline).foregroundColor(.red)
                }.buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                searchField
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        ItemRow(item: item)
                    }
                }
                if !self.viewModel.items.isEmpty && viewModel.searchText.isEmpty {
                    Text("Loading next page...")
                        .onAppear {
                            self.viewModel.fetchNextPage()
                    }
                }
            }
            .navigationBarItems(trailing: filterButton)
            .navigationBarTitle(viewModel.filter.rawValue)
            .actionSheet(isPresented: $showFilterSheet, content: { filterSheet })
        }
        .onAppear {
            self.viewModel.fetch()
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
