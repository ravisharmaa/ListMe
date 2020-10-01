//
//  UserInfo.swift
//  ListMe
//
//  Created by Javra Software on 10/1/20.
//

import Foundation

struct UserInfo: Identifiable, Hashable {
    var id: UUID = UUID()
    
    let name: String
}
