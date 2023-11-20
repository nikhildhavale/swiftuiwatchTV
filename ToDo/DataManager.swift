//
//  DataManager.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import Foundation
import CoreData
class DataManager: NSObject, ObservableObject {
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        let storeURL = URL.storeURL(for: "group.todo.nikhil", databaseName: "Model")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { _, _ in }
        
    }
   
}
public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
