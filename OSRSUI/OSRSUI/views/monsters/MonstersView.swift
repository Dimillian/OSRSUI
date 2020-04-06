//
//  MonstersView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 06/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import Foundation
import SwiftUI

struct MonstersView: View {
    @ObservedObject private var viewModel = MonstersViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchField(searchText: $viewModel.searchText)
                ForEach(viewModel.objects) { monster in
                    Text(monster.name)
                }
                if !self.viewModel.objects.isEmpty && viewModel.searchText.isEmpty {
                    Text("Loading next page...")
                        .onAppear {
                            self.viewModel.fetchNextPage()
                    }
                }
            }
            .navigationBarTitle(Text("Monsters"))
        }
        .onAppear {
            self.viewModel.fetch()
        }
    }
}
