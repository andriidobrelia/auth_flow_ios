//
//  CoreDataManager.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 03.07.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveMainContext()
    func saveBackgroundContext()
}

final class CoreDataManager {
    
    private struct Countries {
        static let dataModel = "CountryDataModel"
    }
    
    static let shared: CoreDataManager = {
        guard let modelURL = Bundle(for: CoreDataManager.self).url(forResource: Countries.dataModel, withExtension: "momd"),
                let manageObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("No data")
        }
        let persistentContainer = NSPersistentContainer(name: Countries.dataModel, managedObjectModel: manageObjectModel)
        return CoreDataManager(persistentContainer: persistentContainer)
    }()
    
    private let persistentContainer: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.loadPersistentStores{_, error in
        }
        
        self.backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
}

extension CoreDataManager: CoreDataManagerProtocol {
    func saveMainContext() {
        save(context: self.mainContext)
    }
    
    func saveBackgroundContext() {
        save(context: self.backgroundContext)
    }
    
    private func save(context: NSManagedObjectContext){
        context.perform {
            guard context.hasChanges else {
                return
            }
            do {
                try context.save()
            } catch {
                let contextError = error as NSError
                assertionFailure(contextError.localizedDescription)
            }
        }
    }
    
    
}
