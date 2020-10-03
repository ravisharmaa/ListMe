//
//  OrderForecastView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import SwiftUI

struct OrderForecastView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.5647058824, green: 0.6078431373, blue: 0.6980392157, alpha: 1))
            VStack(alignment: .leading, spacing: 5) {
                Text("Order Forecast")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                Text("For next week")
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                
                VStack(spacing: -15) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .padding()
                    
                    
                    Text("View more suggestions")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top, 10)
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 1, blue: 0.6784313725, alpha: 1)))
                }
                .padding(.top, 20)
                .padding(.bottom, 5)
                
                
                
            }
            
        }
        
        .frame(width: UIScreen.main.bounds.width - 45, height: 500)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
        
    }
}

struct OrderForecastView_Previews: PreviewProvider {
    static var previews: some View {
        OrderForecastView()
    }
}
