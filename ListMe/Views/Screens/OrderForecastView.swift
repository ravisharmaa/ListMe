//
//  OrderForecastView.swift
//  ListMe
//
//  Created by Javra Software on 10/2/20.
//

import SwiftUI

struct OrderForecastView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Order Forecast")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                    .padding(.horizontal, 20)
                Text("this year")
                    .font(.title3)
                    .padding(.horizontal, 20)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.2))
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 350)
        
    }
}

struct OrderForecastView_Previews: PreviewProvider {
    static var previews: some View {
        OrderForecastView()
    }
}
