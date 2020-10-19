//
//  SearchResultView.swift
//  ListMe
//
//  Created by Javra Software on 10/19/20.
//

import SwiftUI

struct SearchResultView: View {
   
    let item: Product
    //let model: BasketViewModel
    
    //var newItemAdded: ((_ item: DummyListFactory)-> Void)?
    
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
                
                
                Stepper(
                    onIncrement: {
                        //let item = DummyListFactory(name: "Getorade", flavour: "FruitPunch", weight: "13 oz")
                        //model.items.append(item)
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
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(item: .init(id: 1, category: "Hello", name: "Hello", flavour: "Hello", unit: "Hello", weight: "Hello", price: 12, packSize: "12", isNew: false))
    }
}
