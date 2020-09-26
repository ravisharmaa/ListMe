//
//  Product.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/26/20.
//

import Foundation

struct Product: Codable, Hashable {
    
    let id: Int?
    let categoryId: Int?
    let supplierId: Int?
    let name: String?
    let flavour: String?
    let unit: String?
    let price: Int?
    let minimumOrderQuantity: String?
    let inStock: Bool?
    let isNew: Bool?
    let offerPrice: Int?
    let offerValidTill: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case categoryId = "category_id"
        case supplierId = "supplier_id"
        case name, flavour, unit
        case minimumOrderQuantity = "minmum_order_quantity"
        case inStock = "in_stock"
        case isNew = "is_new"
        case offerPrice = "offer_price"
        case offerValidTill = "offer_valid_till"
    }
    
    static var placeholder: Product {
        return .init(id: nil, categoryId: nil, supplierId: nil, name: nil, flavour: nil, unit: nil, price: nil, minimumOrderQuantity: nil, inStock: nil, isNew: nil, offerPrice: nil, offerValidTill: nil)
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
