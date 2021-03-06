//
//  CategoryViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/29/20.
//

import Foundation
import Combine


class CategoryViewModel: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    
    @Published private (set) var categories: [Category] = []
    
    func store(postData: [String: Any]) {
        
        NetworkManager.shared.sendRequest(to: ApiConstants.CateogryPath.description , method: .post, model: [Category].self, postData: postData)
            .receive(on: RunLoop.main)
            .catch({ (error) -> AnyPublisher<[Category], Never> in
                print(error)
                return Just([Category.placeholder]).eraseToAnyPublisher()
            })
            .sink { (_) in
                
            } receiveValue: { [unowned self] (category) in
                categories = category
                
            }.store(in: &subscription)
    }
    
    func all() {
        
        NetworkManager.shared.sendRequest(to: ApiConstants.CateogryPath.description, model: [Category].self)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<[Category], Never> in
                return Just([Category.placeholder]).eraseToAnyPublisher()
            }.sink { (_) in
                //
            } receiveValue: { [unowned self] (categories) in
                
                self.categories = categories
                
            }.store(in: &subscription)
    }
    
    func delete(category: Category) {
        
        let path = ApiConstants.CateogryPath.description + "/\(category.id ?? Int())/delete"
        
        NetworkManager.shared.sendRequest(to: path, method: .delete, model: GenericResponse.self)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<GenericResponse, Never> in
                return Just(GenericResponse.placeholder).eraseToAnyPublisher()
            }
            .sink { (_) in
                //
            }.store(in: &subscription)
    }
    
    func update(category: Category, postData: [String:Any]) {
        
    }
}
