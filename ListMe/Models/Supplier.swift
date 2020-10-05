//
//  Supplier.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/5/20.
//

import Foundation

struct Supplier: Codable, Hashable {
    
    var uuid: UUID = UUID()
    
    let id: Int?
    
    let name: String?
    
    let latitude: Float?
    
    let longitude: Float?
    
    let phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case latitude, longitude
        case phoneNumber = "phone_number"
    }
    
    static var placeholder: Supplier {
        return .init(id: nil, name: nil, latitude: nil, longitude: nil, phoneNumber: nil)
    }
}
