//
//  UserRegistrationForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/28/20.
//

import SwiftUI

struct UserRegistrationForm: View {
    
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    @State var selection:Int = 0
    
    @State var showingLogin: Bool = false
    
    var body: some View {
        UITableView.appearance().showsVerticalScrollIndicator = false
        
        
        return NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Please Input Your Name", text: $userViewModel.name)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                    
                }
                Section(header: Text("Email")) {
                    TextField("Please Input Your Email", text: $userViewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Password")) {
                    SecureField("Please Input Your Password", text: $userViewModel.password)
                }
                
                Section(header: Text("You are")) {
                    Picker("Role", selection: $selection) {
                        ForEach(0..<userViewModel.userInfo.count) { info in
                            Text(userViewModel.userInfo[info].name)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }.listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                
                if  selection == 0 {
                    Section(header: Text("Business Name")) {
                        TextField("Name", text: $userViewModel.businessName)
                    }
                    
                    Section(header: Text("Address")) {
                        TextField("Street", text: $userViewModel.street)
                        TextField("City", text: $userViewModel.city)
                        
                        HStack {
                            TextField("Zip", text: $userViewModel.zip)
                            TextField("State", text: $userViewModel.state)
                        }
                    }
                    Section(header: Text("Contact")) {
                        TextField("Telephone", text: $userViewModel.telephone)
                            .keyboardType(.phonePad)
                    }
                } else {
                    Section(header: Text("Your Zip Code and State ")) {
                        HStack {
                            TextField("Zip", text: $userViewModel.zip)
                            TextField("State", text: $userViewModel.state)
                        }
                    }
                    Section(header: Text("Business Name")) {
                        TextField("Name", text: $userViewModel.businessName)
                    }
                }
                Section {
                    VStack(spacing: 15) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                userViewModel.preferredUserInfo = selection
                                userViewModel.signUp()
                            }, label: {
                                Text("Sign Up").fontWeight(.medium)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 149, height: 45)
                            .background(Color.black)
                            .cornerRadius(20)
                            
                            Spacer()
                        }
                        
                        Button(action: {
                            showingLogin.toggle()
                        }, label: {
                            Text("Have An Account? Login")
                        })
                        .sheet(isPresented: $showingLogin, content: {
                            DemoView()
                        })
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    }.foregroundColor(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
            }
            .navigationBarTitle("Sign Up")
        }
    }
}

struct DemoView: View {
    
    var body: some View {
        Text("Hello world")
    }
}

struct UserRegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationForm()
    }
}
