//
//  ListViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    
    @Published var name: String = String()
    
    @Published var sendToSupplier: String = String()
    
    @Published var forStore: String = String()
    
    @Published var listItems: [ListItem] = [
        .init(name: "Hello world", supplierName: "sendToSupplier", storeName: "forStore", items: nil)
        
    ]
    
    var subscription: Set<AnyCancellable> = []
    
    public func addItem() {
        
        let item: ListItem = .init(name: name, supplierName: sendToSupplier, storeName: forStore, items: nil)
        
        listItems.append(item)
    }
    
}
