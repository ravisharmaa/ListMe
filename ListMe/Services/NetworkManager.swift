//
//  NetworkManager.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/26/20.
//

import UIKit
import Combine

protocol ApiConfiguration {
    
    var path: String { get }
}


enum ApplicationError:  Error {
    case InvalidURL
    case InvalidResponse
    case InvalidData
    case JSONError
    case PostDataError
    case APIError(reason: Error)
    case NotFound(data: Data)
    case UnProcessableEntity
}


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private var urlComponents: URLComponents =  {
        var component = URLComponents()
        component.scheme = ApiConstants.URLScheme.description
        component.host = ApiConstants.Host.description
        return component
        
    }()
    
}

enum RequestMethod: CustomStringConvertible {
    case get
    case post
    case put
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}

extension NetworkManager: ApiConfiguration {
    
    
    internal var path: String {
        return ApiConstants.NetworkPrefix.description
    }
    
    func sendRequest<T: Codable>(to endpoint: String,
                                 method: RequestMethod = .get,
                                 model: T.Type,
                                 queryItems: [String: Any]? = nil,
                                 postData: [String: Any]? = nil,
                                 needsHeaders: Bool = true)  -> AnyPublisher<T, ApplicationError>
    {
        
        var innerUrl = urlComponents
        
        innerUrl.path = path + endpoint
        
        var urlQueryItem: [URLQueryItem] = []
        
        if let queryItems = queryItems {
            for (key, data) in queryItems where queryItems.count > 0 {
                urlQueryItem.append(.init(name:key, value: data as? String))
            }
        }
        
        if !urlQueryItem.isEmpty {
            innerUrl.queryItems = urlQueryItem
        }
        
        
        guard let url = innerUrl.url else {
            return Empty<T, ApplicationError>().eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.description
        
        // add data to post request
        
        if let postData = postData, !postData.isEmpty {
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if needsHeaders {
                urlRequest.addValue("Bearer", forHTTPHeaderField: "Authorization")
            }
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
                return Empty<T, ApplicationError>().eraseToAnyPublisher()
            }
            urlRequest.httpBody = httpBody
        }
        
        let urlPublisher = URLSession.shared.dataTaskPublisher(for: urlRequest)
        
        return urlPublisher.tryMap({ (element) -> Data in
            
            guard let response = element.response as? HTTPURLResponse else {
                throw ApplicationError.InvalidResponse
            }
            
            if response.statusCode == 500 {
                throw ApplicationError.NotFound(data: element.data)
            }
            
            if response.statusCode == 404 {
                throw ApplicationError.NotFound(data: element.data)
            }
            
            if response.statusCode == 422 {
                throw ApplicationError.UnProcessableEntity
            }
            
            return element.data
        })
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error -> ApplicationError in
            if let error = error as? ApplicationError {
                return error
            } else {
                
                print(error)
                
                return ApplicationError.APIError(reason: error)
            }
        }
        .eraseToAnyPublisher()
    }
}
