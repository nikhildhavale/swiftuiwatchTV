//
//  DataManager.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import Foundation
import CoreData
class DataManager: NSObject, ObservableObject {
    @Published var todos: [Todo] = [Todo]()
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
   
}
