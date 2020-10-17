//
//  StoreViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/15/20.
//

import Foundation
import Combine

class StoreViewModel: ObservableObject {
    
    @Published var storeNames: [String] = []
    
    var subscription: Set<AnyCancellable> = []
    
    public func fetch() {
        NetworkManager.shared.sendRequest(to: ApiConstants.StorePath.description, model: [Store].self)
            .receive(on: RunLoop.main)
            .sink { (_) in
                //
            } receiveValue: { [self] (stores) in
                storeNames = stores.map({ (store) -> String in
                    return store.name
                })
            }.store(in: &subscription)
        
    }
}
