//
//  User.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/9/20.
//

import Foundation


struct UserResponse: Codable, Hashable {
    
    let accessToken: String
    
    let tokenType: String
    
    let user: User?
    
    let success: Bool
    
    let uuid: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case user
        case success
    }
    
    static var placeholder: UserResponse {
        return .init(accessToken: "accessToke", tokenType: "Token", user: .init(id: 1, name: "ravi", roleId: 1, email: "test"), success: false)
    }
    
    
}

struct User: Codable, Hashable {
    
    let id: Int
    let name: String
    let roleId: Int
    let email: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case roleId = "role_id"
        case email, name
    }
    
    
}
