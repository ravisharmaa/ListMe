//
//  ListCollectionView.swift
//  ListMe
//
//  Created by Javra Software on 10/10/20.
//

import SwiftUI


struct ListCollectionView: View {
    
    @State private var isListFormPresented: Bool = false
    
    @ObservedObject var listViewModel: CartViewModel = CartViewModel()
    
    @Binding var isLoggedIn: Bool
    
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
                    
                    if listViewModel.inCompleteItems.count > 0 {
                        IncompleteItemsListView(cardItems: $listViewModel.inCompleteItems)
                    }
                    
                    Button(action: {
                        isListFormPresented.toggle()
                    }, label: {
                        
                        Text("Create New list")
                            .font(.title3)
                    })
                    .frame(width:UIScreen.main.bounds.width - 95)
                    .frame(height: 28)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.2117647059, green: 0.3647058824, blue: 1, alpha: 1)))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .sheet(isPresented: $isListFormPresented, content: {
                        ListForm(closeList: $isListFormPresented, didAddItem: { item in
                            listViewModel.addItem(item: item)
                        })
                    })
                    
                    if listViewModel.completedItems.count > 0 {
                        ListCardView(cardItems: listViewModel.completedItems)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("View all older lists.")
                                .foregroundColor(.blue)
                        })
                        .padding(.top, -10)
                    }
                    Spacer()
                    
                }
                
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .onAppear {
                    listViewModel.fetch()
                }
            }
            
        }
    
    }
}

struct ListCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionView(isLoggedIn: .constant(false))
    }
}
