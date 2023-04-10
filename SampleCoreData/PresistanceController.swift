//
//  PresistanceController.swift
//  SampleCoreData
//
//  Created by Capgemini-DA161 on 4/7/23.
//

import Foundation
import CoreData

struct PersistanceController {
    
    let container: NSPersistentContainer
    static let shared = PersistanceController()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    static var preview: PersistanceController = {
        let result = PersistanceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newCompany = Company(context: viewContext)
        newCompany.name = "Apple"
        
        shared.saveContext()
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Intro")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error  as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
