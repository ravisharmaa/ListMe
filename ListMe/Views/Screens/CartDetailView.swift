//
//  CartDetailView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/17/20.
//

import SwiftUI

struct CartDetailView: View {
    
    @Environment (\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var searchViewShown: Bool = false
    
    let item: CartItem
    
    @ObservedObject var viewModel: CartViewModel = CartViewModel()
    
    // MARK:- Navigation Bar View
    var navigationBarItemView: some View {
        return HStack(spacing: 15) {
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "barcode.viewfinder")
            })
            .padding(.trailing, 5)
            
            Button(action: {
                searchViewShown.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
            })
            .padding(.trailing, 5)
            .sheet(isPresented: $searchViewShown, content: {
                SearchView(isSearchShown: $searchViewShown, viewModel: viewModel, cart: item)
            })
            
            Button(action: {
                
            }, label: {
                Image(systemName: "ellipsis.circle")
            })
            
        }
        .font(.title2)
    }
    
    // MARK:- Back Button View
    var backButtonView: some View {
        return Button(action: {
            mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left").font(.title2)
            
        })
    }
    
    //MARK:- Heading View
    var headingView: some View {
        HStack {
            backButtonView
            
            Spacer()
            navigationBarItemView
        }
    }
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    headingView
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                                .font(.title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            if viewModel.cartProducts.count == 0 {
                                Text("\(item.productCount.description) \(item.productCount <= 1 ? "Item": "Items")    Created: \(item.createdAt ?? "") ")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            } else {
                                Text("\(viewModel.cartProducts.count.description) \(viewModel.cartProducts.count <= 1 ? "Item": "Items")    Created: \(item.createdAt ?? "") ")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                    
                    LazyVGrid(columns: layout, spacing: 12) {
                        ForEach(viewModel.cartProducts, id: \.self) { item in
                            
                            ZStack {
                                HStack(spacing: 5) {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .fill(Color.gray.opacity(0.4))
                                        .frame(height: 80)
                                        .frame(width: 70)
                                        .padding(.horizontal)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(item.name!)
                                            .font(.body)
                                            .fontWeight(.semibold)
                                        Text("item.flavour!")
                                            .fontWeight(.regular)
                                            .font(.caption)
                                        
                                        HStack {
                                            Text(item.weight!)
                                                .foregroundColor(.gray)
                                                .fontWeight(.regular)
                                                .font(.caption)
                                            
                                            Text("In: \(item.category!)")
                                                .foregroundColor(.gray)
                                                .fontWeight(.regular)
                                                .font(.caption)
                                            
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                            .frame(height: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
                            )
                            .padding(.horizontal, 10)
                            .animation(.easeIn)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear(perform: {
            viewModel.fetchProductOf(cart: item)
        })
        .navigationTitle("Hello")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView(item: .init(name: "Demo", supplierName: "Demo", storeName: "Demo", productCount: 0, completedAt: nil, createdAt: nil, slug: "slug"), viewModel: .init())
    }
}
