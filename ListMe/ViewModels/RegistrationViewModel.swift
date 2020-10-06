//
//  UserViewModel.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/1/20.
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
    
    @Published var didCompleteSignUp: Bool = false
    
    @Published var signupStatus: Bool = false
    
    var subscription: Set<AnyCancellable> = []
    
    var isFormValid: Bool {
        return isValidEmail()
    }
        
    //MARK:- ValidationMethods
    private func isValidEmail() -> Bool {
        return ValidationStates.EmailValidation(email).validated
    }
    
    init() {
        if isValidEmail() {
            $email
                .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                .map { (email) -> String in
                    return email
                }.sink { [unowned self] (validatedEmail) in
                    
                    NetworkManager.shared.sendRequest(to: "email", model: GenericResponse.self)
                        .receive(on: RunLoop.main)
                        .catch { (error) -> AnyPublisher<GenericResponse, Never> in
                            return Just(GenericResponse.placeholder).eraseToAnyPublisher()
                        }.sink { (_) in
                            //
                        } receiveValue: { (response) in
                            
                        }.store(in: &subscription)
                }.store(in: &subscription)
        }
    }
    
    public func signUp()  {
        
        let postData: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation":password,
            "role": userInfo[preferredUserInfo].name,
            "businessName": businessName,
            "street": street,
            "city": city,
            "zip": zip,
            "state": state,
            "telephone": telephone
        ]
        
        
        NetworkManager.shared.sendRequest(to: ApiConstants.RegistrationPath.description,
                                          method: .post,
                                          model: GenericResponse.self,
                                          postData: postData)
            .receive(on: RunLoop.main)
            .catch { (_) -> AnyPublisher<GenericResponse, Never> in
                return Just(GenericResponse.placeholder).eraseToAnyPublisher()
            }
            .sink { (_) in
                //
            } receiveValue: { [unowned self](response) in
                
                didCompleteSignUp.toggle()
                
                signupStatus = response.success
                
            }.store(in: &subscription)
    }
    
    public func login() {
        
    }
    
    private func checkEmail(email: String) {
        
    }
    
}
