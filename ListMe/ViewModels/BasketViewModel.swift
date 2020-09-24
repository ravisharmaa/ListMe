//
//  BasketViewModel.swift
//  ListMe
//
//  Created by Javra Software on 9/24/20.
//

import Foundation
import SwiftUI
import Combine

class BasketViewModel: ObservableObject {
    
    var subject: PassthroughSubject = PassthroughSubject<ListItem, Never>()
    
    @Published var items: [ListItem] = [
        ListItem(id: 1, name: "Doritos", flavour: "Ranch Onion", weight: "12oz"),
        ListItem(id: 2, name: "Lays", flavour: "Origional", weight: "12oz"),
        ListItem(id: 3, name: "Coke", flavour: "Soda", weight: "12oz"),
        ListItem(id: 4, name: "Sprite", flavour: "Lemon", weight: "12oz")
    ]
    
}
