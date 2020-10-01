//
//  BasketViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/24/20.
//

import Foundation
import SwiftUI
import Combine

class BasketViewModel: ObservableObject {
    
    @Published var searchText: String = String()
    
    @Published var items: [ListItem] = [
        ListItem(name: "Doritos", flavour: "Ranch Onion", weight: "12oz"),
        ListItem(name: "Lays", flavour: "Origional", weight: "12oz"),
        ListItem(name: "Coke", flavour: "Soda", weight: "12oz"),
        ListItem(name: "Sprite", flavour: "Lemon", weight: "12oz")
    ]
    
    var subscription: Set<AnyCancellable> = []
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { (output) -> String in
                return output
            }.sink { (_) in
                //
            } receiveValue: { (searchField) in
                print(searchField)
            }.store(in: &subscription)
    }
    
}
