//
//  ProductViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/27/20.
//

import Foundation
import Combine


class ProductViewModel: ObservableObject {
    
    var actionCompleted: PassthroughSubject = PassthroughSubject<Bool, Never>()
    
    var subscription: Set<AnyCancellable> = []
    
    func saveProduct(postData: [String: Any]) {
        
        print(postData)
        
        let path = ApiConstants.ProductPath.description + "/create"
        
        print(path)
        
        NetworkManager.shared.sendRequest(to: path, method: .post, model: GenericResponse.self, postData: postData)
            .receive(on: RunLoop.main)
            .catch({ (error) -> AnyPublisher<GenericResponse, Never> in
                print(error)
                return Just(GenericResponse.placeholder).eraseToAnyPublisher()
            })
            .sink { (_) in
                //
            } receiveValue: { (response) in
                print(response)
               
            }.store(in: &subscription)
        
    }
}
