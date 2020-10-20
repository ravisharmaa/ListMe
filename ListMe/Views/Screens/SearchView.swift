//
//  SearchView.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var isSearchShown: Bool
    
    let layout = [
        GridItem(.flexible())
    ]
    
    @StateObject var productViewModel: ProductViewModel = ProductViewModel()
    
    var viewModel: CartViewModel
    
    let cart: CartItem
    
    var textField: some View {
        
        return TextField("Enter Search Text", text: $productViewModel.searchText)
            .padding(.horizontal, 40)
            .padding(.leading, 10)
            .frame(width: UIScreen.main.bounds.width - 110, height: 45, alignment: .leading)
            .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
            .clipped()
            .cornerRadius(10)
            .font(.callout)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
            )
    }
    
    var searchField: some View {
        
        return HStack {
            
            textField
            
            Spacer()
            
            Button(action: {
                isSearchShown.toggle()
            }, label: {
                Text("Close")
                    .foregroundColor(.blue)
            })
            .foregroundColor(.blue)
            .font(.title3)
        }.padding()
    }
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9758560663, green: 0.9758560663, blue: 0.9758560663, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack(alignment: .leading, spacing: -3) {
                    searchField
                    
                    if productViewModel.products.count > 0 {
                        Text("\(productViewModel.products.count) \(productViewModel.products.count <= 1 ? "result": "results") found")
                            .foregroundColor(.gray)
                            .padding(.leading, 20)
                            .font(.subheadline)
                    }
                }
                
                if productViewModel.isDataEmpty {
                    
                    VStack{
                        
                        Spacer()
                        
                        Text("Sorry the item you searched is not available.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                }
                
                if productViewModel.isSearching {
                    
                    Spacer()
                    
                    ProgressView()
                        .font(.title)
                    
                    Spacer()
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ForEach(productViewModel.products, id: \.self) { item in
                                ItemView(item: item, cart: cart, viewModel: viewModel)
                            }
                        }
                    }.id(UUID().uuidString)
                }
            }
            
        }
    }
}

struct ItemView: View {
    
    let item: Product
    
    let cart: CartItem
    
    var viewModel: CartViewModel
    
    var body: some View {
        
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
                    Text(item.flavour!)
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
                                
                HStack {
                    Button {
                        viewModel.populate(add: false, product: item, toBasket: cart)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    
                    Button {
                        viewModel.populate(add: true, product: item, toBasket: cart)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                .foregroundColor(.gray)
                .padding(.trailing, 20)
                
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


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isSearchShown: .constant(false), viewModel: .init(), cart: .init(name: "demo", supplierName: "demo", storeName: "demo", productCount: 4, completedAt: nil, createdAt: nil, slug: "demo"))
    }
}
