//
//  LoginForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import SwiftUI

struct LoginForm: View {
    
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    @State var selection:Int = 0
    
    @State var showingLogin: Bool = false
    
    @State var present: Bool = false
    
    var body: some View {
            ZStack {
                
                Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.leading, 30)
                        
                        Text("Please provide the login details.")
                            .foregroundColor(.gray)
                            .padding(.leading, 30)
                            .padding(.top, 8)
                    }
                    .padding(.top, 150)
                    .padding(.bottom, 20)
                    
                    
                    FloatingTextField(title: "Email", text: $loginViewModel.email, height: 65, isSecure: false)
                        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    FloatingTextField(title: "Password", text: $loginViewModel.password, height: 65, isSecure: true)
                        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                        .padding(.top, -20)
                    
                    Spacer()
                    
                    VStack(spacing: 25) {
                        
                            Button(action: {
                                
                                withAnimation {
                                    present.toggle()
                                }
                                
                                
                            }, label: {
                                Text("Login")
                                    .font(.headline)
                            })
                            .frame(maxWidth: .infinity)
                            .frame(height: 28)
                            .padding()
                            .background(Color(#colorLiteral(red: 0.2117647059, green: 0.3647058824, blue: 1, alpha: 1)))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.blue)
                        })
                    }
                    .padding()
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 15)
                
                
                ZStack {
                    LaunchScreen()
                        .edgesIgnoringSafeArea(.all)
                        .offset(x:0, y: present ? 0 : UIApplication.shared.keyWindow?.frame.height ?? 0)
                }
            }
    }
    
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
