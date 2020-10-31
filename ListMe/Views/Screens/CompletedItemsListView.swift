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
           
            // show checkmark circle if the list is completed and calculate the padding respectively.
            
            if item.completedAt != nil {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .padding(.leading, 13)
                    .padding(.trailing, 4)
            }
           
            VStack(alignment: .leading, spacing: 5) {
                
                Text(item.name)
                    .font(.headline)
                
                Text("October 20 2020")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading, item.completedAt != nil ? 0 : 42) // calculate the padding dynamiclly based on the item's completedAt flag.
            
            Spacer()
            Spacer()
            
            HStack {
                Capsule(style: .continuous)
                    .padding()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3))
                    .overlay(
                        Text(item.productCount.description)
                            .font(.caption)
                            .foregroundColor(.black)
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
