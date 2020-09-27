//
//  GenericResponse.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/26/20.
//

import Foundation

struct GenericResponse: Codable {
    let success: Bool
    
    static var placeholder: GenericResponse {
        return .init(success: false)
    }
}
