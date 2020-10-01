

//
//  Constants.swift
//  NewsApp
//
//  Created by Ravi Bastola on 8/25/20.
//

import Foundation


enum ApiConstants: CustomStringConvertible {
    
    case NetworkPath
    case URLScheme
    case Host
    case CateogryPath
    case ProductPath
    
    var description: String {
        
        switch self {
        
        case .NetworkPath:
            return "/api/"
        case .URLScheme:
            return "http"
        case .Host:
            return "list-me.test"
        case .CateogryPath:
            return "categories"
        case .ProductPath:
            return "products"
        }
    }
}

enum ValidationConstants: CustomStringConvertible {
    
    case EmailConstant
    
    var description: String {
        switch self {
        case .EmailConstant:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
    }
}

enum ValidationStates {
    
    case EmailValidation(String)
    
    var validated: Bool {
        
        switch self {
        
        case .EmailValidation(let stringTobeValidatedAgainst):
            return NSPredicate(format: "SELF MATCHES %@", ValidationConstants.EmailConstant.description).evaluate(with: stringTobeValidatedAgainst)
            
        }
    }
}
