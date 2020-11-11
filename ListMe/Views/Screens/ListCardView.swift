//
//  CompletedListsCardView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/10/20.
//

import SwiftUI

struct ListCardView: View {
    @Binding var cardItems: [CartItem]
    
    @State var showSearchView: Bool = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            LazyVStack {
                ForEach(cardItems, id: \.id) { item in
                    NavigationLink(destination: CartDetailView(cartItem: item)) {
                        CompletedItemsListView(item: item)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Divider()
                        .foregroundColor(Color.black.opacity(0.4))
                        .padding(.horizontal, 20)
                        .padding(.leading, 20)
                        .padding(.trailing, 10)
                    
                }                
            }
            .padding(.top, 20)
        }
        .navigationBarHidden(true)
        .foregroundColor(.black)
        .frame(width: UIScreen.main.bounds.width - 45)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct CompletedListsCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(cardItems: .constant([
            .init(name: "Hello", supplierName: "hello", storeName: "Hello", productCount: 0, completedAt: "hello", createdAt: nil, slug: "slug")
        ]))
    }
}
