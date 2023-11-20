//
//  AddToDo.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import SwiftUI

struct AddToDo: View {
    @State var text:String = ""
    @Binding var showAdd:Bool
    var body: some View {
        NavigationStack{
            getTextEditor()
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button("Cancel",action: {
                            showAdd = false
                        })
                    })
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Done", action: {
                            showAdd = false
                        })
                    })
                    
                })
            
        }
        
    }
    @ViewBuilder func getTextEditor() -> some View
    {
        Form{
#if os(watchOS)
            TextField("", text: $text)
#else
            TextEditor(text: $text)
#endif
        }
        
    }
}

