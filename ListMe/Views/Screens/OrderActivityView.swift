//
//  OrderActivityView.swift
//  ListMe
//
//  Created by Javra Software on 10/2/20.
//

import SwiftUI

struct OrderActivityView: View {
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)).opacity(0.2)
            VStack(alignment: .leading, spacing: 5) {
                Text("Order activity")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                    .padding(.horizontal, 20)
                Text("This year")
                    .font(.title3)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -5)
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(Color.green.opacity(0.3))
                    .padding(.top, 8)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 8)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 400)
        .cornerRadius(30)
        
    }
}

struct OrderActivityView_Previews: PreviewProvider {
    static var previews: some View {
        OrderActivityView()
    }
}
