//
//  ListItem.swift
//  ListMe
//
//  Created by Javra Software on 9/24/20.
//

import Foundation


struct ListItem: Identifiable, Hashable {
    
    let id: UUID = UUID()
    let name: String
    let flavour: String
    let weight: String
}
