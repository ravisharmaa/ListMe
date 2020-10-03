//
//  OrderActivityView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/2/20.
//

import SwiftUI

struct OrderActivityView: View {
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9058823529, green: 0.9254901961, blue: 0.9607843137, alpha: 1))
            VStack(alignment: .leading, spacing: 5) {
                Text("Order activity")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                    .padding(.horizontal, 20)
                Text("This year")
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .padding(.bottom, -5)
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666667, green: 0.7529411765, blue: 1, alpha: 1)))
                    .padding()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 45, height: 400)
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1)), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
        
    }
}

struct OrderActivityView_Previews: PreviewProvider {
    static var previews: some View {
        OrderActivityView()
    }
}
