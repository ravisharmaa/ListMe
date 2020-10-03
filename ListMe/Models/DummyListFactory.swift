//
//  ListItem.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/24/20.
//

import Foundation


struct DummyListFactory: Identifiable, Hashable {
    
    let id: UUID = UUID()
    let name: String
    let flavour: String
    let weight: String
}
