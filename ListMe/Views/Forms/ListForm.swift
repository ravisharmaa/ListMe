//
//  ListForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import SwiftUI


struct ListForm: View {
    
    @ObservedObject var listViewModel: ListViewModel = ListViewModel()
    
    var isModalClosed: (()-> Void)?
    
    var body: some View {
        
        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        return  NavigationView {
            
            Form {
                Section(header: Text("List Name")) {
                    TextField("Name", text: $listViewModel.name)
                }
                
                Section(header: Text("Send To Supplier")) {
                    TextField("Name", text: $listViewModel.sendToSupplier)
                }
                
                Section(header: Text("For Store")) {
                    TextField("For Store", text: $listViewModel.forStore)
                }
                
                Section {
                    
                    HStack(alignment: .center) {
                        
                        Spacer()
                        
                        Button(action: {
                            listViewModel.addItem()
                            isModalClosed?()
                            
                        }, label: {
                            Text("Create").fontWeight(.medium)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 149, height: 45)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        
                        Spacer()
                    }
                    
                    
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
            }
            .navigationBarTitle("Create new list")
            .navigationBarItems(leading: Button(action: {
                isModalClosed?()
            }, label: {
                Text("Close")
            }))
            
        }
    }
}

struct ListForm_Previews: PreviewProvider {
    static var previews: some View {
        ListForm()
    }
}

