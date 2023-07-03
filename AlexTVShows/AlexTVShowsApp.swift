//
//  AlexTVShowsApp.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import SwiftUI

@main
struct AlexTVShowsApp: App {
    let persistenceController = ATSPersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ATSDashboardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
