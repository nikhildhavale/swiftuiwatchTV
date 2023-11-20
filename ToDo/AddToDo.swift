//
//  AddToDo.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import SwiftUI

struct AddToDo: View {
    @State var text:String = ""
    @Binding var isPresented:Bool
    @FocusState var focus:Bool
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        NavigationStack{
            getTextEditor()
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button("Cancel",action: {
                            isPresented = false
                        })
                    })
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Done", action: {
                            isPresented = false
                            saveTodo()
                        })
                    })
                    
                })
            
        }.onAppear{
            focus = true 
        }
        
    }
    func saveTodo()
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
    @ViewBuilder func getTextEditor() -> some View
    {
        Form{
#if os(watchOS)
            TextField("", text: $text).focused($focus)
#else
            TextEditor(text: $text).focused($focus)
#endif
        }
        
    }
}

