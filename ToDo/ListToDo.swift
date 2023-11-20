//
//  ListToDo.swift
//  ToDo
//
//  Created by Nikhil Dhavale on 20/11/23.
//

import SwiftUI

struct ListToDoView: View {
    @State var showAdd = false
    var body: some View {
        NavigationStack{
            List{
                Text("Prayer")
            }.toolbarTitleDisplayMode(.inline).navigationTitle("Prayer Points").toolbar(content: {
                Button(action: {
                    showAdd.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            })
        }.sheet(isPresented: $showAdd, content: {
            AddToDo(text: "",showAdd: $showAdd)
        })
    }
}

class ListToDoViewModel:ObservableObject
{
    
}
