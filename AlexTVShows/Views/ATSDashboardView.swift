//
//  ATSDashboard.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSDashboardView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case list
        case favorite
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

struct ATSDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ATSDashboardView()
    }
}
