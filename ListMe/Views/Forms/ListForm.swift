//
//  ListForm.swift
//  ListMe
//
//  Created by Javra Software on 10/2/20.
//

import SwiftUI


struct ListForm: View {
    
    @Binding var isPresented: Bool
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Name")) {
                    //TextField(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>)
                }
            }
            .navigationBarTitle("Create new list")
            .navigationBarItems(leading: Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Close")
            }))
        }
    }
}

struct ListForm_Previews: PreviewProvider {
    static var previews: some View {
        ListForm(isPresented: .constant(false))
    }
}

