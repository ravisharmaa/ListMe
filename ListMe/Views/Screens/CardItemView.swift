//
//  CardItemView.swift
//  ListMe
//
//  Created by Javra Software on 10/10/20.
//

import SwiftUI

struct CardItemView: View {
    
    let item: CartItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                
                Text(item.name)
                    .font(.headline)
                
                Text("Created at")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, 30)
            
            Spacer()
            Spacer()
            
            HStack {
                Capsule(style: .continuous)
                    .padding()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.4))
                    .overlay(
                        Text(item.items?.count.description ?? 0.description)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    )
                    
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.8))
                    .padding(.trailing, 10)
            }
            .padding(.trailing, 20)
            
        }
    }
}


struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView(item: .init(name: "Dummy ITem", supplierName: "Sangam Bhandari", storeName: "Sangam", items: nil, completedAt: "false"))
    }
}