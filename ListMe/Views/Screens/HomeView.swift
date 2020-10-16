//
//  HomeView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/1/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var listViewModel: CartViewModel = CartViewModel()
    
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
                    
                    ListCardView(cardItems: $listViewModel.completedItems.wrappedValue)
                    
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
