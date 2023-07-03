//
//  ATSDashboard.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

struct ATSDashboardView: View {
    //MARK: - Enviroment
    @Environment(\.managedObjectContext) private var viewContext
    
    //MARK: - State
    @State private var selection: Tab = .list
    
    private enum Tab {
        case list
        case favorite
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ATSTvShowsView(type: .all)
                .tabItem {
                    Label("TVShows", systemImage: "tv")
                }
                .tag(Tab.list)
            
            ATSTvShowsView(type: .favorite)
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }
                .tag(Tab.favorite)
        }
    }
}

struct ATSDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ATSDashboardView().environment(\.managedObjectContext, ATSPersistenceController.preview.container.viewContext)
    }
}
