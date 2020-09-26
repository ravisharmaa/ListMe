

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
