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
    
    let items: [Product]?
    
    let completedAt: String?
    
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name, supplierName, storeName
        case completedAt = "completed_at"
        
        case items = "cart_product"
        case createdAt = "created_at"
    }
        
    static var placeholder: CartItem {
        return .init(name: "Dummy", supplierName: "Dummy", storeName: "Dummy", items: nil, completedAt: "false", createdAt: nil)
    }
}
