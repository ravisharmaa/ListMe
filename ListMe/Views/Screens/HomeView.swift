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
            Color(#colorLiteral(red: 0.909655273, green: 0.9337338209, blue: 0.9539583325, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Your recent pickings are shown below")
                    }
                    .offset(x: -20)
                    
                    ListCardView()
                        
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Create New list")
                            .font(.subheadline)
                    })
                    .frame(width:UIScreen.main.bounds.width - 95)
                    .frame(height: 28)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    
                    OrderView()
                    
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
        List {
            Text("Hello world")
            Text("Helllo world")
        }
        
        .frame(width: UIScreen.main.bounds.width - 45, height: 350)
        .cornerRadius(30)
        .listStyle(InsetListStyle())
        .listRowInsets(.init(top: 10, leading: 10, bottom: 30, trailing: 10))
    }
}

struct OrderView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Order activity")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                Text("this Year")
                    .font(.title3)
                    .padding(.horizontal, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.gray)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 350)
        
    }
    
}

struct OrderForecastView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Order Forecast")
                    .font(.title)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                Text("this year")
                    .font(.title3)
                    .padding(.horizontal, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.gray)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 350)
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
