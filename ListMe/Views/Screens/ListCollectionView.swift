//
//  ListCollectionView.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/10/20.
//

import SwiftUI


struct ListCollectionView: View {
    
    @State private var isListFormPresented: Bool = false
    
    @ObservedObject var listViewModel: CartViewModel = CartViewModel()
    
    @Binding var isLoggedIn: Bool
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
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
                        
                        if listViewModel.cartItems.count > 0 {
                            IncompleteItemsListView(cardItems: $listViewModel.cartItems)
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
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ListCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListCollectionView(isLoggedIn: .constant(false))
    }
}
