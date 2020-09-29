//
//  ProductForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/27/20.
//

import SwiftUI

struct ProductForm: View {
    
    @State private var name: String = String()
    
    @State private var flavour: String = String()
    
    @State private var weight: String = String()
    
    var productUnit: [String] = ["Single","Pack","Case"]
    
    var quantityMetrics: [String] = ["oz","fl. oz"]
    
    @State private var selectedUnit: Int = 1
    
    @State private var selectedQuantity: Int = 0
    
    let closeModal: (()-> Void)?
    
    let productViewModel: ProductViewModel = ProductViewModel()
    
    let category: Category
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Product Name", text: $name)
                }
                
                Section(header: Text("Flavor/Variant")) {
                    TextField("Flavor", text: $flavour)
                }
                
                Section(header:  Text("Order Unit")) {
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(0..<productUnit.count) {
                            Text(productUnit[$0])
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:  Text("Please Input Weight")) {
                    HStack {
                        TextField("Weight", text: $weight).keyboardType(.numberPad)
                        Picker("Unit", selection: $selectedQuantity) {
                            ForEach(0..<quantityMetrics.count) {
                                Text(quantityMetrics[$0])
                            }
                            
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationBarTitle("Add Product in \(category.name!)")
            .navigationBarItems(leading: Button("Close", action: {
                
                closeModal?()
                
            }), trailing: Button("Save", action: {
                
                let postData: [String: Any] = [
                    "name": name,
                    "unit": productUnit[selectedUnit],
                    "quantity": quantityMetrics[selectedQuantity],
                    "flavour": flavour,
                    "price":500,
                    "weight":weight,
                    "minimum_order_quantity":12,
                    "in_stock":0,
                    "is_new":1,
                    "offer_price":1200,
                    "offer_label":"Christmas",
                    "offer_valid_till":"2020-12-20",
                    "category_id":category.id!
                ]
                
                productViewModel.saveProduct(postData: postData)
                closeModal?()
                
            }))
        }
    }
}

struct ProductForm_Previews: PreviewProvider {
    static var previews: some View {
        ProductForm(closeModal: nil,  category: .init(name: "Some Category", id: 1) )
    }
}
