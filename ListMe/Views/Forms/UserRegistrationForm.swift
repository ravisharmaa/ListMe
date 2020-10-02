//
//  UserRegistrationForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/28/20.
//

import SwiftUI

struct UserRegistrationForm: View {
    
    @ObservedObject var registrationViewModel: RegistrationViewModel = RegistrationViewModel()
    
    @State var selection:Int = 0
    
    @Binding var closeRegistration: Bool
    
    
    var body: some View {
        
        UITableView.appearance().showsVerticalScrollIndicator = false
        
        return NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Input your name", text: $registrationViewModel.name)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                    
                }
                Section(header: Text("Email")) {
                    TextField("Input Your Email", text: $registrationViewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Password")) {
                    SecureField("Input Your Password", text: $registrationViewModel.password)
                }
                
                Section(header: Text("You are")) {
                    Picker("Role", selection: $selection) {
                        ForEach(0..<registrationViewModel.userInfo.count) { info in
                            Text(registrationViewModel.userInfo[info].name)
                        }
                    }
                    .font(.title)
                    .pickerStyle(SegmentedPickerStyle())
                }.listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                
                if  selection == 0 {
                    Section(header: Text("Business Name")) {
                        TextField("Name", text: $registrationViewModel.businessName)
                    }
                    
                    Section(header: Text("Address")) {
                        TextField("Street", text: $registrationViewModel.street)
                        TextField("City", text: $registrationViewModel.city)
                        
                        HStack {
                            TextField("Zip", text: $registrationViewModel.zip)
                            TextField("State", text: $registrationViewModel.state)
                        }
                    }
                    Section(header: Text("Contact")) {
                        TextField("Telephone", text: $registrationViewModel.telephone)
                            .keyboardType(.phonePad)
                    }
                } else {
                    Section(header: Text("Your Zip Code and State ")) {
                        HStack {
                            TextField("Zip", text: $registrationViewModel.zip)
                            TextField("State", text: $registrationViewModel.state)
                        }
                    }
                    Section(header: Text("Business Name")) {
                        TextField("Name", text: $registrationViewModel.businessName)
                    }
                }
                Section {
                    VStack(spacing: 15) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                registrationViewModel.preferredUserInfo = selection
                                registrationViewModel.signUp()
                            }, label: {
                                Text("Sign Up").fontWeight(.medium)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 149, height: 45)
                            .background(Color.black)
                            .cornerRadius(20)
                            .disabled(!registrationViewModel.isFormValid)
                            
                            Spacer()
                        }
                        
                        Button(action: {
                            closeRegistration.toggle()
                        }, label: {
                            Text("Have An Account? Login")
                        })
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    }.foregroundColor(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9485785365, green: 0.9502450824, blue: 0.9668951631, alpha: 1)))
            }
            .font(.subheadline)
            .navigationBarTitle("Sign Up")
            .navigationBarItems(trailing: Button(action: {
                closeRegistration.toggle()
            }, label: {
                Text("Close")
                    .foregroundColor(.blue)
            }))
        }
    }
}

struct UserRegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationForm(closeRegistration: .constant(false))
    }
}
