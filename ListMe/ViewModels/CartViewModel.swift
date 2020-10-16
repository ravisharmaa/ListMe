//
//  ListViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import Foundation
import Combine

class CartViewModel: ObservableObject {
    
    @Published var name: String = String()
    
    @Published var sendToSupplier: String = String()
    
    @Published var forStore: String = String()
    
    var subscription: Set<AnyCancellable> = []
    
    @Published var completedItems: [CartItem] = []
    
    @Published var inCompleteItems: [CartItem] = []
    
    public func addItem() {
        
        let item: CartItem = .init(name: name, supplierName: sendToSupplier, storeName: forStore, items: nil, completedAt: "true")
        
        completedItems.append(item)
    }
    
    public func fetch() {
        
        // use acutal user id
        let url: String = ApiConstants.CartPath.description + "/1"
        
        NetworkManager.shared.sendRequest(to: url, model: [CartItem].self)
            .receive(on: RunLoop.main)
            .sink { (_) in
                //
            } receiveValue: { [self](cartItems) in
                
                completedItems = cartItems.filter{ $0.completedAt != nil }
                
                inCompleteItems = cartItems.filter{ $0.completedAt == nil }
                
            }.store(in: &subscription)
    }
    
}
