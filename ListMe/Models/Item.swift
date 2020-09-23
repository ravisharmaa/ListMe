//
//  Item.swift
//  ListMe
//
//  Created by Javra Software on 9/22/20.
//

import Foundation


struct Item: Codable, Hashable {
    
    let name: String
    let barCode: BarCode?
    let image: String
    let flavour: String?
    let weight: String
    let unit: String
    let supplier: [Supplier]?
    let uuid: UUID = UUID()
    
    struct BarCode: Codable, Hashable {
        let type: String
        let number: Int
    }
    
    struct Supplier: Codable, Hashable {
        let name: String
        let location: String
    }
    
    enum CodingKeys: String, CodingKey {
        case name,image,flavour,weight,unit
        case supplier
        case barCode
        case uuid
    }
}

struct Store: Codable, Hashable {
    let id: Int
    let name: String
    let location: String
}

struct ItemCategory: Codable, Hashable {
    var name: String
    var items: [Item]?
}
