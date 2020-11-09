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
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .center, spacing: 13) {
                        
                        VStack {
                            
                            Circle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(#colorLiteral(red: 0.4250360727, green: 0.3812525868, blue: 0.9664649367, alpha: 1)))
                            
                            
                            Text("Joe Biden")
                                .font(.title)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.top, 5)
                            
                            Text("joe@biden.com")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                        }
                        
                        Spacer()
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 300)
                                    .foregroundColor(.white)
                                    .shadow(color: Color.gray.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                                    .padding(.bottom, 20)
                                
                                VStack {
                                    HStack(alignment: .center) {
                                        Text("Forecast Notifications")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                        
                                        
                                        
                                        Toggle("", isOn: $employeeStatus)
                                            .padding(.trailing, 5)
                                        
                                    }
                                    .padding(.top, 20)
                                    .padding(.horizontal, 20)
                                    
                                    
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                        .padding(.top, 10)
                                    
                                    HStack(alignment: .center) {
                                        Text("Edit Profile")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .padding(.trailing, 5)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    
                                    HStack(alignment: .center) {
                                        
                                        NavigationLink(
                                            destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                                            label: {
                                                Text("Stores Info")
                                                    .foregroundColor(.black)
                                                    .fontWeight(.medium)
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .padding(.trailing, 5)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack(alignment: .center) {
                                        Text("Associated Users")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .padding(.trailing, 5)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack(alignment: .center) {
                                        Text("Logout")
                                            .foregroundColor(.black)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    
                                    Spacer()
                                }
                                
                                
                            }
                        }
                        .font(.subheadline)
                    }
                    .padding()
                }
                
                
            }
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
