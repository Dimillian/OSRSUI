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
    
    var body: some View {
        NavigationView {
            List {
                SearchField(searchText: $viewModel.searchText)
                ForEach(viewModel.objects) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        ItemRow(item: item)
                    }
                }
                if !self.viewModel.objects.isEmpty && viewModel.searchText.isEmpty {
                    Text("Loading next page...")
                        .onAppear {
                            self.viewModel.fetchNextPage()
                    }
                }
            }
            .navigationBarItems(trailing: filterButton
                .actionSheet(isPresented: $showFilterSheet, content: { filterSheet }))
            .navigationBarTitle(viewModel.filter.rawValue)
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
