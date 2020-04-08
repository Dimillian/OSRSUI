//
//  PrayersView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 08/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct PrayersView: View {
    @ObservedObject private var viewModel = PrayersViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchField(searchText: $viewModel.searchText)
                ForEach(viewModel.objects) { prayer in
                    PrayerRow(prayer: prayer)
                }
                if !viewModel.objects.isEmpty && viewModel.searchText.isEmpty && viewModel.canLoadMorePages {
                    Text("Loading next page...")
                        .onAppear {
                            self.viewModel.fetchNextPage()
                    }
                }
            }
            .navigationBarTitle(Text("Prayers"))
        }
        .onAppear {
            self.viewModel.fetch()
        }
    }
}
