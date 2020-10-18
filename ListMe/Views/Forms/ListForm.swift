//
//  ListForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import SwiftUI


struct ListForm: View {
    
    @ObservedObject var listViewModel: CartViewModel = CartViewModel()
    
    var isModalClosed: (()-> Void)?
    
    @State var presentSupplierPicker: Bool = false
    
    @State var presentStorePicker: Bool = false
    
    @State var supplierPicker: String = String()
    
    @State var storePicker: String = String()
    
    @Binding var closeList: Bool
    
    @ObservedObject var supplierViewModel: SupplierViewModel = SupplierViewModel()
    
    @ObservedObject var storeViewModel: StoreViewModel = StoreViewModel()
    
    var didAddItem: (CartItem) -> ()
    
    var body: some View {
        
        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        return ZStack {
            
            NavigationView {
                
                Form {
                    Section(header: Text("List Name")) {
                        TextField("Name", text: $listViewModel.name)
                    }
                    
                    Section(header: Text("Send To Supplier")) {
                        TextField("Name", text: $supplierPicker)
                            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                presentSupplierPicker = true
                            })
                    }
                    
                    Section(header: Text("For Store")) {
                        TextField("For Store", text: $storePicker)
                            .onTapGesture(count: 1, perform: {
                                presentStorePicker.toggle()
                            })
                    }
                    
                  
                    Section {
                        
                        HStack(alignment: .center) {
                            
                            Spacer()
                            
                            Button(action: {
                                didAddItem(.init(name: listViewModel.name, supplierName: supplierPicker, storeName: storePicker, items: nil, completedAt: String(), createdAt: nil
                                ))
                                supplierPicker = String()
                                storePicker = String()
                                closeList.toggle()
                            }, label: {
                                Text("Create List")
                                    .font(.headline)
                            })
                            .frame(maxWidth: .infinity)
                            .frame(height: 25)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.2117647059, green: 0.3647058824, blue: 1, alpha: 1)))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                        }
                        
                        
                    }
                    .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                }
                .navigationBarTitle("Create new list")
                .navigationBarItems(trailing: Button(action: {
                    closeList.toggle()
                    isModalClosed?()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.title)
                }))
                
            }.onAppear(perform: {
                supplierViewModel.fetch()
                storeViewModel.fetch()
            })
            
            if presentSupplierPicker {
                withAnimation(.spring()) {
                    CustomPickerView(items: supplierViewModel.supplierName, presentPicker: $presentSupplierPicker, pickerField: $supplierPicker, pickerTitle: "Supplier")
                }
            }
            
            if presentStorePicker {
                withAnimation(.spring()) {
                    CustomPickerView(items: storeViewModel.storeNames, presentPicker: $presentStorePicker, pickerField: $storePicker, pickerTitle: "Store")
                }
            }
        }
        
        
    }
}

struct ListForm_Previews: PreviewProvider {
    static var previews: some View {
        ListForm(closeList: .constant(false), didAddItem: { item in
            //
        })
    }
}

