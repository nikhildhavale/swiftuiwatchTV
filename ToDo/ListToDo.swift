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
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
    private var todos: FetchedResults<Todo>

    var body: some View {
        NavigationStack{
            List{
                ForEach(todos, id:\.self) { todos in
#if os(watchOS)
                    NavigationLink(todos.desc ?? "", destination: {
                       showToDoPage()
                    })
#else
                    NavigationLink(todos.desc ?? "", destination: {
                        PageView(pages: self.todos.map{Text($0.desc ?? "")}, currentPage: self.todos.firstIndex(of: todos) ?? 0)
                    })
#endif
                }.onDelete(perform: delete)
            }
            .toolbarTitleDisplayMode(.inline).navigationTitle("ToDo").toolbar(content: {
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
    /// we can use this for ios too but learning integration of uiivewcontroller representable
    func showToDoPage() -> some View
    {
        TabView {
            ForEach(self.todos, id: \.self) { todo in
                Text(todo.desc ?? "" )
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    func saveTodo(text:String)
    {
        let todo = Todo(context: self.viewContext)
        todo.desc = text
        todo.id = Date().timeIntervalSince1970
        do{
            try self.viewContext.save()
        }
        catch
        {
            
        }
    }
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            self.viewContext.delete(todo)
            do {
                try viewContext.save()
            } catch {
                // handle the Core Data error
            }
        }
    }
}
