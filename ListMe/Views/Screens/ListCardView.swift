//
//  ListCardView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/10/20.
//

import SwiftUI

struct ListCardView: View {
    
    let cardItems: [CartItem]
    
    var body: some View {
        
        ZStack {
            Color.white
            LazyVStack {
                ForEach(cardItems, id: \.self) { item in 
                    CardItemView(item: item)
                    Divider()
                        .padding(.horizontal, 20)
                }
            }
            .padding(.top, 20)
        }
        .foregroundColor(.black)
        .frame(width: UIScreen.main.bounds.width - 45)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.4), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
    }
    
}

struct ListCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(cardItems: [
            
        ])
    }
}
