//
//  UserRegistrationForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/28/20.
//

import SwiftUI

struct UserRegistrationForm: View {
    
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        
        //UITableView.appearance().showsVerticalScrollIndicator = false
        NavigationView {
                Form {
                    
                    Section(header: Text("Name")) {
                        TextField("Please Input Your Name", text: $userViewModel.name)
                            .keyboardType(.default)
                    }
                    
                    Section(header: Text("Email")) {
                        TextField("Please Input Your Email", text: $userViewModel.email)
                            .keyboardType(.emailAddress)
                    }
                    
                    Section(header: Text("Password")) {
                        SecureField("Please Input Your Password", text: $userViewModel.password)
                    }
                    
                    Section(header: Text("You are")) {
                        Picker("Role", selection: $userViewModel.preferredUserInfo) {
                            
                            ForEach(0..<userViewModel.userInfo.count) { info in
                                Text(userViewModel.userInfo[info].name)
                            }
                            
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                    
                    if  userViewModel.preferredUserInfo == 0 {
                        
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
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                userViewModel.save()
                            }, label: {
                                Text("Sign Up").fontWeight(.heavy)
                            })
                            
                            .frame(width: 180, height: 45, alignment: .center)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                            Spacer()
                            
                        }
                        .foregroundColor(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                        
                    }.listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))

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
