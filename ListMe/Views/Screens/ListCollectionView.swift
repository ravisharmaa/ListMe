//
//  ListCollectionView.swift
//  ListMe
//
//  Created by Javra Software on 10/10/20.
//

import SwiftUI


struct DummyCardItems: Identifiable, Hashable {
    let id: UUID = UUID()
    let cardItemName: String
    let createdDate: String
    let itemCount: Int
}

struct ListCollectionView: View {
    
    let cardItems: [DummyCardItems] = [
        .init(cardItemName: "Cash and Carry Pickup", createdDate: "Created Sept 18, 2020", itemCount: 999),
        .init(cardItemName: "VicksBurg Order", createdDate: "Created Sept 18, 2020", itemCount: 444),
        .init(cardItemName: "Long Distribution", createdDate: "Created Sept 18, 2020", itemCount: 231),
        .init(cardItemName: "Pizza Collection", createdDate: "Created Sept 18, 2020", itemCount: 123),
        .init(cardItemName: "Dominos Collection", createdDate: "Created Sept 18, 2020", itemCount: 12),
        .init(cardItemName: "Technical Collection", createdDate: "Created Sept 18, 2020", itemCount: 10),
        .init(cardItemName: "Miscellaneous Collection", createdDate: "Created Sept 18, 2020", itemCount: 2),
        .init(cardItemName: "Miscellaneous Collection", createdDate: "Created Sept 18, 2020", itemCount: 2)
    ]
    
   
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("All Lists")
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Text("Your active lists are shown below")
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 60)
                    .offset(x: -45)
                    
                    
                    ListCardView(cardItems: cardItems)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Create New list")
                            .font(.title3)
                    })
                    .frame(width:UIScreen.main.bounds.width - 95)
                    .frame(height: 28)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.2117647059, green: 0.3647058824, blue: 1, alpha: 1)))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    
                    CompletedListsCardView(cardItems: cardItems)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("View all older lists.")
                            .foregroundColor(.blue)
                    })
                    .padding(.top, -10)
                    
                    Spacer()
                    
                }
                
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                
            }
            
        }
    }
}

struct ListCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionView()
    }
}
