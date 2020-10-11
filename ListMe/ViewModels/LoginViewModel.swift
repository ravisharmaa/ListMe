//
//  LoginViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/8/20.
//

import Foundation
import Combine


class LoginViewModel: ObservableObject {
    
    @Published var email: String = String()
    
    @Published var password: String = String()
    
    var subscription: Set<AnyCancellable> = []
    
    var isFormValid: Bool {
        return isValidEmail()
    }
    
    @Published var loginResponse: UserResponse!
    
    @Published var isLoginSuccessFul: Bool = false
    
    @Published var didLoginFail: Bool = false
    
    //MARK:- ValidationMethods
    private func isValidEmail() -> Bool {
        return ValidationStates.EmailValidation(email).validated
    }
    
    
    public func login() {
        let postData: [String: String] = [
            "email" : email,
            "password": password
        ]
        
        NetworkManager.shared.sendRequest(to: ApiConstants.LoginPath.description, method: .post , model: UserResponse.self, postData: postData)
            .receive(on: RunLoop.main)
            .sink { [unowned self] (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    didLoginFail.toggle()
                }
            } receiveValue: { [unowned self] (response) in
                loginResponse = response
                isLoginSuccessFul.toggle()
                
            }
            .store(in: &subscription)
    }
}
