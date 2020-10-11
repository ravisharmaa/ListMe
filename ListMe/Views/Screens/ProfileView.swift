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
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 13) {
                    
                    VStack {
                        
                        Circle()
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(#colorLiteral(red: 0.4250360727, green: 0.3812525868, blue: 0.9664649367, alpha: 1)))
                        
                        
                        Text("Donald Trump")
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.top, 5)
                        
                        Text("donald@trump.com")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Edit Profile")
                                .foregroundColor(.blue)
                        })
                        .padding(.vertical, 10)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .foregroundColor(.white)
                                .shadow(color: Color.gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                                .padding(.bottom, 20)
                            
                            HStack(alignment: .center) {
                                Text("Forecast Notifications")
                                    .foregroundColor(.black)
                                
                                Toggle("", isOn: $employeeStatus)
                                    .padding(.trailing, 5)
                            }
                            .padding()
                            .padding(.bottom, 20)
                        }
                        
                        Text("Your Stores")
                            .padding(.horizontal)
                            .foregroundColor(.gray)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
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
                                
                                VStack(spacing: -13) {
                                    Text("Store Id")
                                        .foregroundColor(.gray)
                                        .font(.callout)
                                        .padding()
                                        .padding(.trailing, 5)
                                        .padding(.top, 9)
                                    
                                    Text("A1245")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 14)
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Add Stores")
                                .foregroundColor(.blue)
                        })
                        .padding(.top, 15)
                        .padding(.horizontal)
                        
                        Text("Associated Users")
                            .padding(.top, 30)
                            .padding(.horizontal, 10)
                            .foregroundColor(.gray)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .foregroundColor(.white)
                                .shadow(color: Color.gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Mike Pence")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("Employee")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                }.padding()
                                
                                Spacer()
                                
                                VStack {
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Edit")
                                            .padding()
                                    })
                                    .padding(.trailing, 5)
                                    
                                    Spacer()
                                }
                            }
                            
                        }
                    }
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
