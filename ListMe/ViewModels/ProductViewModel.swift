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
    
    @Published private (set) var products: [Product] = []
    
    @Published var searchText: String = String()
    
    // MARK:- Initiliazer for product view model.
    
    init() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.products = []
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                searchItems(searchText: searchField)
            }.store(in: &subscription)
    }
    
    
    private func searchItems(searchText: String) {
        
        NetworkManager.shared.sendRequest(to: ApiConstants.ProductSearchPath.description, model: Products.self, queryItems: ["name": searchText])
            .receive(on: RunLoop.main)
            .sink { (completed) in
                //
            } receiveValue: { [self] (searchedProducts) in
                products = searchedProducts
            }.store(in: &subscription)
    }
    
    //MARK:- Saves A Product
    
    func store(postData: [String: Any]) {
        
        let path = ApiConstants.ProductPath.description + "/create"
        
        NetworkManager.shared.sendRequest(to: path, method: .post, model: [Product].self, postData: postData)
            .receive(on: RunLoop.main)
            .catch({ (error) -> AnyPublisher<[Product], Never> in
                return Just([Product.placeholder]).eraseToAnyPublisher()
            })
            .sink { (_) in
                
            } receiveValue: { [unowned self] (product) in
                products = product
                
            }.store(in: &subscription)
    }
    
    //MARK:- Fetches Products
    
    func all(category: Category) {
        
        let path = ApiConstants.ProductPath.description + "/\(category.name ?? "")"
        
        NetworkManager.shared.sendRequest(to: path, model: Products.self)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<Products, Never> in
                return Just([Product.placeholder]).eraseToAnyPublisher()
            }.sink { (_) in
                //
            } receiveValue: { [unowned self] (products) in
                
                self.products = products
                
            }.store(in: &subscription)
    }
    
    // MARK:- Deletes a product
    
    func destroy(product: Product) {
        
        let path = ApiConstants.ProductPath.description + "/\(product.id ?? Int())/delete"
        
        NetworkManager.shared.sendRequest(to: path, method: .delete, model: GenericResponse.self)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<GenericResponse, Never> in
                return Just(GenericResponse.placeholder).eraseToAnyPublisher()
            }
            .sink { (_) in
                //
            }.store(in: &subscription)
    }
    
    func update(product: Product, postData: [String: Any]) {
        let path = ApiConstants.ProductPath.description + "/\(product.id ?? Int())/update"
        
        NetworkManager.shared.sendRequest(to: path, method: .put, model: Products.self, postData: postData)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<Products, Never> in
    
                return Just([Product.placeholder]).eraseToAnyPublisher()
            }.sink { (_) in
                //
            } receiveValue: { [unowned self] (products) in
                self.products = products
            }.store(in: &subscription)
    }
}
