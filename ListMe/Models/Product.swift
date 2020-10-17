//
//  Product.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/26/20.
//

import Foundation

struct Product: Codable, Hashable {
    
    let id: Int?
    let category: String?
   // let supplierId: Int?
    let name: String?
    let flavour: String?
    let unit: String?
    let weight: String?
    let price: Int?
    let packSize: String?
    //let minimumOrderQuantity: String?
    //let inStock: Bool?
    let isNew: Bool?
    //let offerPrice: Int?
    //let offerValidTill: String?
    
    let uuid: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case uuid
        case category = "category_name"
        //case supplierId = "supplier_id"
        case name, flavour, unit
        //case minimumOrderQuantity = "minmum_order_quantity"
        //case inStock = "in_stock"
        case isNew = "is_new"
        //case offerPrice = "offer_price"
        //case offerValidTill = "offer_valid_till"
        case packSize = "pack_size"
        case weight
    }
    
    static var placeholder: Product {
       return
        .init(id: nil, category: nil, name: nil, flavour: nil, unit: nil, weight: nil, price: nil, packSize: nil, isNew: nil)
    }
}

typealias Products = [Product]

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        //
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
