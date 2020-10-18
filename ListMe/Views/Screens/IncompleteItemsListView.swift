//
//  CompletedListsCardView.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/10/20.
//

import SwiftUI

struct IncompleteItemsListView: View {
    @Binding var cardItems: [CartItem]
    
    @State var showSearchView: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            LazyVStack {
                ForEach(cardItems, id: \.self) { item in
                    
                    NavigationLink(destination: CartDetailView(item: item)) {
                        CompletedItemsListView(item: item)
                    }
                    Divider()
                        .foregroundColor(Color.black.opacity(0.4))
                        .padding(.horizontal, 20)
                    
                }                
            }
            .padding(.top, 20)
        }
        .foregroundColor(.black)
        .frame(width: UIScreen.main.bounds.width - 45)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
    }
}

struct CompletedListsCardView_Previews: PreviewProvider {
    static var previews: some View {
        IncompleteItemsListView(cardItems: .constant([
            .init(name: "Hello", supplierName: "hello", storeName: "Hello", items: nil, completedAt: "hello", createdAt: nil)
        ]))
    }
}
