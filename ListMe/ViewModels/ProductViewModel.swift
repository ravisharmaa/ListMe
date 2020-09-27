//
//  ProductViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/27/20.
//

import Foundation
import Combine


class ProductViewModel: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    
    func saveProduct(postData: [String: Any]) {
        
        let path = ApiConstants.ProductPath.description + "/create"
        
        NetworkManager.shared.sendRequest(to: path, method: .post, model: GenericResponse.self, postData: postData)
            .receive(on: RunLoop.main)
            .catch({ (error) -> AnyPublisher<GenericResponse, Never> in
                return Just(GenericResponse.placeholder).eraseToAnyPublisher()
            })
            .sink { (_) in
                //
            } receiveValue: { (_) in
                //
               
            }.store(in: &subscription)
        
    }
}
