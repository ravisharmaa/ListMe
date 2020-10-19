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
    
    var subscription: Set<AnyCancellable> = []
    
    @Published var completedItems: [CartItem] = []
    
    @Published var inCompleteItems: [CartItem] = []
    
    public func addItem(item: CartItem) {
        
        let postData: [String: Any] = [
            "name"         : item.name,
            "storeName"    : item.storeName,
            "supplierName" : item.supplierName ?? "",
            "completedAt"  : item.completedAt ?? String()
        ]
        
        // remove static user id send the currently logged in user.
        
        let path = ApiConstants.CartPath.description + "/1/create"
        
        NetworkManager.shared.sendRequest(to: path,
                                          method: .post,
                                          model: CartItem.self,
                                          postData: postData)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [self] (response) in
                response.completedAt == nil ? inCompleteItems.append(response) : completedItems.append(response)
            }
            .store(in: &subscription)
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
