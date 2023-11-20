//
//  ListToDo.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import SwiftUI

struct ListToDoView: View {
    @State var isPresented = false
    @EnvironmentObject var manager: DataManager
    @FetchRequest(sortDescriptors: [])
    private var todos: FetchedResults<Todo>

    var body: some View {
        NavigationStack{
            List{
                ForEach(todos, id:\.self) { todos in
                    Text(todos.desc ?? "" )
                }
            }.toolbarTitleDisplayMode(.inline).navigationTitle("ToDo").toolbar(content: {
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            })
        }.sheet(isPresented: $isPresented, content: {
            AddToDo(text: "",isPresented: $isPresented)
        }).environmentObject(manager)
            .environment(\.managedObjectContext,manager.container.viewContext)
    }
}
