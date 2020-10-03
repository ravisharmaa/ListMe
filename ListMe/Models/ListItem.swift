//
//  ListItem.swift
//  ListMe
//
//  Created by Javra Software on 10/3/20.
//

import Foundation

struct ListItem: Hashable, Identifiable {
    
    let id: UUID = UUID()
    
    let name: String
    
    let supplierName: String
    
    let storeName: String
    
    let items: [Item]?
}
