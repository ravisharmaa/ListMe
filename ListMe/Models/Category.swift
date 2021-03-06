//
//  Category.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/25/20.
//

import Foundation

struct Category: Codable, Hashable {
    let name: String?
    let id: Int?
    let uuid: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case uuid
    }
    
    static var placeholder: Category {
        return .init(name: nil, id: nil)
    }
    
    
}
