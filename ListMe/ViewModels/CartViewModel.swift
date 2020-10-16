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
        
        item.completedAt == String() ? inCompleteItems.append(item) : completedItems.append(item)
        
        print(item)
        
        let postData: [String: Any] = [
            "name"         : item.name,
            "storeName"    : item.storeName,
            "supplierName" : item.supplierName,
            "completedAt"  : item.completedAt ?? String()
        ]
        
        let path = ApiConstants.CartPath.description + "/1/create"
        
        NetworkManager.shared.sendRequest(to: path,
                                          method: .post,
                                          model: GenericResponse.self,
                                          postData: postData)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (response) in
                print(response)
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
