//
//  ListItem.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/3/20.
//

import Foundation

struct CartItem: Codable, Hashable, Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    
    let supplierName: String?
    
    let storeName: String
    
    let productCount: Int
    
    let completedAt: String?
    
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name, supplierName, storeName
        case completedAt = "completed_at"
    
        case createdAt = "created_at"
        case productCount = "product_count"
    }
        
    static var placeholder: CartItem {
        return .init(name: "Dummy", supplierName: "Dummy", storeName: "Dummy", productCount: 0, completedAt: "false", createdAt: nil)
    }
}
