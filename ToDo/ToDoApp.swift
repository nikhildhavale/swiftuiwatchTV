//
//  ToDoApp.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject private var manager: DataManager = DataManager()

    var body: some Scene {
        WindowGroup {
            ListToDoView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
