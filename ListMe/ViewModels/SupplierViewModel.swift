//
//  SupplierViewModel.swift
//  ListMe
//
//  Created by Javra Software on 10/5/20.
//

import Foundation
import Combine

class SupplierViewModel: ObservableObject {
    
    @Published var suppliers: [Supplier] = []
    
    @Published var supplierName: [String] = []
    
    var subscription: Set<AnyCancellable> = []
    
    public func fetch() {
        NetworkManager.shared.sendRequest(to: ApiConstants.SupplierPath.description, model: [Supplier].self)
            .receive(on: RunLoop.main)
            .catch { (_) -> AnyPublisher<[Supplier], Never> in
                return Just([Supplier.placeholder]).eraseToAnyPublisher()
            }.sink { (_) in
                //
            } receiveValue: { [self](suppliers) in
                supplierName = suppliers.map({ (supplier) -> String in
                    return supplier.name ?? ""
                })
            }.store(in: &subscription)
    }
}
