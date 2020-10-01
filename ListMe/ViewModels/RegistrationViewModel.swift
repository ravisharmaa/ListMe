//
//  UserViewModel.swift
//  ListMe
//
//  Created by Javra Software on 10/1/20.
//

import Combine
import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = String()
    
    @Published var password: String = String()
    
    @Published var name: String = String()
    
    var userInfo: [UserInfo] = [
        UserInfo(name: "Business Owner"),
        UserInfo(name: "Employee")
    ]
    
    var preferredUserInfo = 0
    
    @Published var businessName: String = String()
    
    @Published var street: String = String()
    
    @Published var city: String = String()
    
    @Published var zip: String = String()
    
    @Published var state: String = String()
    
    @Published var telephone: String = String()
    
    
    var isFormValid: Bool {
        return isValidEmail()
    }
    
    //MARK:- ValidationMethods
    private func isValidEmail() -> Bool {
        return ValidationStates.EmailValidation(email).validated
    }
    
    
    public func signUp() {
       
        if !email.isEmpty, !password.isEmpty, !businessName.isEmpty, !state.isEmpty, !street.isEmpty {
            
        }
    }
    
    public func login() {
        
    }
    
}
