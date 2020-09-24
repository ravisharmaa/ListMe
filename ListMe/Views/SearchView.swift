//
//  SearchView.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = String()
    
    let isModalClosed: (()-> Void)?
    
    let layout = [
        GridItem(.flexible())
    ]
    
    @ObservedObject var basketModel = BasketViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("Enter Search Text", text: $searchText)
                    .padding(.horizontal, 40)
                    .frame(width: UIScreen.main.bounds.width - 90, height: 45, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        }
                    )
                Spacer()
                Button(action: {
                    isModalClosed?()
                }, label: {
                    Text("Close")
                })
                .font(.title3)
            }.padding()
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, spacing: 12) {
                    ForEach(basketModel.items, id: \.self) { item in
                        ItemView(item: item, model: basketModel)
                    }
                }
            }
        }
        .background(Color(#colorLiteral(red: 0.9758560663, green: 0.9758560663, blue: 0.9758560663, alpha: 1)))
    }
}

struct ItemView: View {
    
    let item: ListItem
    let model: BasketViewModel
    
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 5) {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .fill(Color.gray.opacity(0.4))
                    .frame(height: 80)
                    .frame(width: 70)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.name)
                        .font(.title3)
                        .fontWeight(.heavy)
                    Text(item.flavour)
                        .fontWeight(.regular)
                        .font(.subheadline)
                    Text(item.weight)
                        .fontWeight(.regular)
                        .font(.subheadline)
                }
                
                Spacer()
                
                
                Stepper(
                    onIncrement: {
                        let item = ListItem(id: 1, name: "a", flavour: "a", weight: "a")
                        model.subject.send(item)
                    },
                    onDecrement: {
                        
                    },
                    label: {
                       EmptyView()
                    })
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isModalClosed: nil)
            .edgesIgnoringSafeArea(.all)
    }
}
