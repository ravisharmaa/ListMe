//
//  CategoryForm.swift
//  ListMe
//
//  Created by Javra Software on 9/29/20.
//

import SwiftUI

struct CategoryForm: View {
    
    @State private var name: String = String()
    
    let closeModal: (()-> Void)?
    
    let categoryViewModel: CategoryViewModel = CategoryViewModel()
    
    let category: Category?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField(category?.name ?? "Category Name", text: $name)
                }
            }
            .navigationBarTitle("Add Category")
            .navigationBarItems(leading: Button("Close", action: {
                
                closeModal?()
                
            }), trailing: Button("Save", action: {
                
                let postData: [String: Any] = [
                    "name": name
                ]
                
                if let category = category  {
                    categoryViewModel.update(category:category, postData: postData)
                } else {
                    categoryViewModel.store(postData: postData)
                }
                
                
                
                closeModal?()
            }))
        }
    }
}

struct CategoryForm_Previews: PreviewProvider {
    static var previews: some View {
        CategoryForm(closeModal: nil, category: nil)
    }
}
