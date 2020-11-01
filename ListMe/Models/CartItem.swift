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
    
    let slug: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name, supplierName, storeName
        case completedAt = "completed_at"
        
        case createdAt = "created_at"
        case productCount = "product_count"
        
        case slug
    }
    
    static var placeholder: CartItem {
        return .init(name: "Dummy", supplierName: "Dummy", storeName: "Dummy", productCount: 0, completedAt: "false", createdAt: nil, slug: "test")
    }
}

extension CartItem {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
        
        storeName = try container.decode(String.self, forKey: .storeName)
        
        productCount = try container.decode(Int.self, forKey: .productCount)
        
        completedAt = try container.decodeIfPresent(String.self, forKey: .completedAt)
        
        let dateString = try container.decode(String.self, forKey: .createdAt)
        
        slug = try container.decode(String.self, forKey: .slug)
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let date = formatter.date(from: dateString) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            createdAt = dateFormatter.string(from: date)
            
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        
    }
}
