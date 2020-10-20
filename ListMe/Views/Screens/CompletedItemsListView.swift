//
//  CompletedCardItemView.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/10/20.
//

import SwiftUI

struct CompletedItemsListView: View {
    let item: CartItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                
                Text("Create")
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
                    //.foregroundColor(Color.white.opacity(0.4))
                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).opacity(0.3))
                    .overlay(
                        Text(item.productCount.description)
                            .font(.caption)
                            .foregroundColor(.white)
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

struct CompletedCardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedItemsListView(item: .init(name: "Dummy", supplierName: "Dummy", storeName: "Dummy", productCount: 0, completedAt: "false", createdAt: nil, slug: "demo"))
    }
}
