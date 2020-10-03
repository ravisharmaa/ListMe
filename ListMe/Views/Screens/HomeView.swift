//
//  HomeView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/1/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack {
            //Color(#colorLiteral(red: 0.8705882353, green: 0.9176470588, blue: 0.9647058824, alpha: 1)).opacity(0.5).edgesIgnoringSafeArea(.all)
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Your recent pickings are shown below")
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 60)
                    .offset(x: -20)
                    
                    ListCardView()
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Create New list")
                            .font(.title3)
                    })
                    .frame(width:UIScreen.main.bounds.width - 95)
                    .frame(height: 28)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.2117647059, green: 0.3647058824, blue: 1, alpha: 1)))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    
                    OrderActivityView()
                    
                    OrderForecastView()
                    
                }
                
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .foregroundColor(.black)
            }
        }
    }
}

struct ListCardView: View {
    var body: some View {
        
        ZStack {
            Color.white
            VStack {
                
                Spacer()
                
                HomeCardListView()
                Divider()
                    .padding(.horizontal, 20)
                HomeCardListView()
                Divider()
                    .padding(.horizontal, 20)
                HomeCardListView()
                Divider()
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("View all lists")
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    
                })
                .padding(.bottom, 30)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 350)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.4), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
    }
}


struct HomeCardListView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Cash & Carry Pickup")
                    .fontWeight(.bold)
                    .font(.callout)
                
                Text("Created Sept 18, 2020")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 30)
            
            Spacer()
            Spacer()
            
            Capsule(style: .continuous)
                .padding()
                .frame(width: 70, height: 70)
                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.4))
                .overlay(
                    Text("999")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                )
                
            Image(systemName: "chevron.right")
                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.8))
            
            Spacer()
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
