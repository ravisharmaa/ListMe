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
        
        UITableView.appearance().showsVerticalScrollIndicator = false
        
        return NavigationView {
            Form {
                
                Section(header: Text("Email / Phone")) {
                    TextField("Enter email or phone", text: $loginViewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Password")) {
                    SecureField("Enter password", text: $loginViewModel.password)
                }
                
                
                Section {
                    VStack(spacing: 15) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                loginViewModel.login()
                                present.toggle()
                            }, label: {
                                Text("Login").fontWeight(.medium)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 149, height: 45)
                            .background(Color.black)
                            .cornerRadius(18)
                            .disabled(!loginViewModel.isFormValid)
                            .fullScreenCover(isPresented: $present) {
                                LaunchTabView()
                                    .background(Color.white)
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(maxWidth: .infinity)
                                    .frame(maxHeight: .infinity)
                            }
                            
                            Spacer()
                        }
                        
                        Button(action: {
                            showingLogin.toggle()
                        }, label: {
                            Text("Need An Account? Sign Up")
                        })
                        .sheet(isPresented: $showingLogin, content: {
                            UserRegistrationForm(closeRegistration: $showingLogin)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    }.foregroundColor(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
            }
            .font(.subheadline)
            .navigationBarTitle("Login")
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
