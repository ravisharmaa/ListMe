//
//  UserViewModel.swift
//  ListMe
//
//  Created by Javra Software on 10/1/20.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    
    var email: String = String()
    
    var password: String = String()
    
    var name: String = String()
    
    var userInfo: [UserInfo] = [
        UserInfo(name: "Business Owner"),
        UserInfo(name: "Employee")
    ]
    
    var preferredUserInfo = 0
    
    var businessName: String = String()
    
    var street: String = String()
    
    var city: String = String()
    
    var zip: String = String()
    
    var state: String = String()
    
    var telephone: String = String()
    
    public func signUp() {
       
        if !email.isEmpty, !password.isEmpty, !businessName.isEmpty, !state.isEmpty, !street.isEmpty {
            
        }
    }
    
    public func login() {
        
    }
    
}
