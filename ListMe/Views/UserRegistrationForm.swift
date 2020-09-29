//
//  UserRegistrationForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/28/20.
//

import SwiftUI

struct UserRegistrationForm: View {
    
    @State private var password: String = String()
    
    @State private var email: String = String()
    
    @State private var name: String = String()
    
    var userInfo = ["Business Owner","Employee"]
    
    @State private var businessName: String = String()
    
    @State var preferredUserInfo = 0
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Name")) {
                    TextField("Please Input Your Name", text: $name)
                        .keyboardType(.default)
                }
                
                
                Section(header: Text("Email")) {
                    TextField("Please Input Your Email", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                Section(header: Text("Password")) {
                    SecureField("Please Input Your Password", text: $password)
                }
                
                Section(header: Text("You are")) {
                    Picker("Role", selection: $preferredUserInfo) {
                        ForEach(0..<userInfo.count) {
                            Text(userInfo[$0])
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
//                if userInfo[preferredUserInfo] == "Business Owner" {
//
//
//                    Section(header: Text("Address")) {
//                        TextField("Please Input Your Business Name", text: $businessName)
//                            .keyboardType(.default)
//
//                        TextField("Street", text: $businessName)
//                            .keyboardType(.default)
//
//                        TextField("City", text: $businessName)
//                            .keyboardType(.default)
//
//                        TextField("Zip", text: $businessName)
//                            .keyboardType(.default)
//
//                        TextField("State", text: $businessName)
//                            .keyboardType(.default)
//
//
//                    }
//
//                    Section(header: Text("Phone Number")) {
//                        TextField("Please Input Your Phone Number", text: $businessName)
//                            .keyboardType(.phonePad)
//                    }
//
//
//
//                } else {
//
//                }
//
//
            }
            .navigationBarTitle("Sign Up")
        }
    }
}

struct UserRegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationForm()
    }
}
