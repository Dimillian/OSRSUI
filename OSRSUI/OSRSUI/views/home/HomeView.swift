//
//  HomeView.swift
//  OSRSUI
//
//  Created by Thomas Ricouard on 28/02/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    enum Tabs: Int, CaseIterable {
        case items, prayers, monsters, map, quests
        
        func title() -> String {
            switch self {
            case .items: return "Items"
            case .prayers: return "Prayers"
            case .monsters: return "Monsters"
            case .map: return "Map"
            case .quests: return "Quests"
            }
        }
        
        func view() -> AnyView {
            switch self {
            case .items:
                return AnyView(ItemsView())
            default:
                return AnyView(Text("Work in progress"))
            }
        }
    }
    
    @State private var selectedTab = Tabs.items
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                tab.view()
                    .tabItem{ Text(tab.title()) }
                    .tag(tab)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
