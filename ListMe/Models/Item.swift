//
//  Item.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/22/20.
//

import Foundation


struct Item: Codable, Hashable {
    
    let name: String
    let barCode: BarCode?
    let image: String?
    let flavour: String?
    let weight: String
    let unit: String
    let uuid: UUID = UUID()
    
    struct BarCode: Codable, Hashable {
        let type: String
        let number: Int
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name,image,flavour,weight,unit
        case barCode
        case uuid
    }
}

struct Store: Codable, Hashable {
    let id: Int
    let name: String
}

struct ItemCategory: Codable, Hashable {
    var name: String
    var items: [Item]?
}
