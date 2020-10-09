//
//  ProfileView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/7/20.
//

import SwiftUI

struct ProfileView: View {
    
    @State var employeeStatus: Bool = true
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Donald Trump")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.top, 60)
                    
                    Text("donald@trump.com")
                        .font(.callout)
                        .padding(.horizontal, 10)
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Edit Profile")
                    })
                    .padding(.horizontal, 10)
                    
                    
                    Text("Stores")
                        .padding(.top, 30)
                        .padding(.horizontal, 10)
                        .foregroundColor(.gray)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 105)
                            .foregroundColor(.white)
                            .shadow(color: Color.gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Store Name")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    
                                Text("4100  Duke Lane, New Jersey 44600 FL")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }.padding()
                            
                            Spacer()
                            
                            Text("Store Code")
                                .foregroundColor(.gray)
                                .font(.callout)
                                .padding()
                                .padding(.trailing, 5)
                        }
                        
                    }
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Add Store")
                    })
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    
                    Text("Associated Users")
                        .padding(.top, 30)
                        .padding(.horizontal, 10)
                        .foregroundColor(.gray)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity)
                            .frame(height: 90)
                            .foregroundColor(.white)
                            .shadow(color: Color.gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Sangam Bhandari")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Employee")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                
                                
                            }.padding()
                            
                            Spacer()
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Edit")
                                    .padding()
                            })
                            .padding(.trailing, 5)
                            
                            
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
