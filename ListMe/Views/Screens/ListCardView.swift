//
//  ListCardView.swift
//  ListMe
//
//  Created by Javra Software on 10/10/20.
//

import SwiftUI

struct ListCardView: View {
    
   
    let cardItems: [DummyCardItems]
    
    var body: some View {
        
        ZStack {
            Color.white
            VStack {
                ForEach(cardItems, id: \.self) { item in 
                    CardItemView(item: item)
                    Divider()
                        .padding(.horizontal, 20)
                }
//                CardItemView()
//                Divider()
//                    .padding(.horizontal, 20)
//                CardItemView()
//                Divider()
//                    .padding(.horizontal, 20)
//                CardItemView()
//                EmptyView()
//                    .padding(.horizontal, 20)
                
                //Spacer()
                
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                    Text("View all lists")
//                        .foregroundColor(.blue)
//                        .fontWeight(.semibold)
//
//                })
//                .padding(.bottom, 30)
                
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
            .init(cardItemName: "Cash and Carry Pickup", createdDate: "Created Sept 18, 2020", itemCount: 999),
            .init(cardItemName: "VicksBurg Order", createdDate: "Created Sept 18, 2020", itemCount: 444),
            .init(cardItemName: "Long Distribution", createdDate: "Created Sept 18, 2020", itemCount: 231),
            .init(cardItemName: "Pizza Collection", createdDate: "Created Sept 18, 2020", itemCount: 123),
            .init(cardItemName: "Dominos Collection", createdDate: "Created Sept 18, 2020", itemCount: 12),
            .init(cardItemName: "Technical Collection", createdDate: "Created Sept 18, 2020", itemCount: 10),
            .init(cardItemName: "Miscellaneous Collection", createdDate: "Created Sept 18, 2020", itemCount: 2)
        ])
    }
}
