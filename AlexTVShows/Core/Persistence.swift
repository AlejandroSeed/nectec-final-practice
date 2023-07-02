//
//  Persistence.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import CoreData

final class ATSPersistenceController {
    //MARK: - Properties
    static let shared = ATSPersistenceController()

    static var preview: ATSPersistenceController = {
        let result = ATSPersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for i in 0..<10 {
            let newItem = TvShow(context: viewContext)
        
            newItem.id = 1
            newItem.name = "Alex Show \(i)"
            newItem.image = URL(string: "https://static.tvmaze.com/uploads/images/medium_landscape/257/644822.jpg")
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    //MARK: - Life Cycle
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AlexTVShows")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
