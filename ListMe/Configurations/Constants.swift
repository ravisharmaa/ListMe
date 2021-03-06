

//
//  Constants.swift
//  NewsApp
//
//  Created by Ravi Bastola on 8/25/20.
//

import Foundation


// MARK:- Api URLS

enum ApiConstants: CustomStringConvertible {
    
    case NetworkPrefix
    case URLScheme
    case Host
    case CateogryPath
    case ProductPath
    case SupplierPath
    case RegistrationPath
    case LoginPath
    case StorePath
    case CartPath
    case ProductSearchPath
    
    var description: String {
        
        switch self {
        
        case .NetworkPrefix:
            return "/api/"
        case .URLScheme:
            return "http"
        case .Host:
            return "list-me.test"
        case .CateogryPath:
            return "categories"
        case .ProductPath:
            return "products"
        case .SupplierPath:
            return "suppliers"
        case .RegistrationPath:
            return "signup"
        case .LoginPath:
            return "login"
        case .StorePath:
            return "stores"
        case .CartPath:
            return "cart"
        case .ProductSearchPath:
            return "search/products"
        }
    }
}

// MARK:- Validation Constants

enum ValidationConstants: CustomStringConvertible {
    
    case EmailConstant
    
    var description: String {
        switch self {
        case .EmailConstant:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
    }
}

//MARK:- Date Strings

enum DateFormatters: CustomStringConvertible {
    
    case YYYYMMDDHHMMSS
    
    var description: String {
        switch self {
        case .YYYYMMDDHHMMSS:
            return "yyyy-MM-dd HH:mm:ss"
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
