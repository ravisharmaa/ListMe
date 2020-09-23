//
//  SearchView.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = String()
    
    let isModalClosed: (()-> Void)?
    
    let data = Array(1...50).map({ "Item \($0)"})
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Enter Search Text", text: $searchText)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 90, height: 40, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                    .clipped()
                    .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
                    isModalClosed?()
                }, label: {
                    Text("Close")
                })
                .font(.title3)
            }
            
            .padding()
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: layout, spacing: 21) {
                    
                    ForEach(data, id: \.self) { item in
                        VStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.blue)
                                .frame(height: 95)
                                .padding(.horizontal)
                                .shadow(radius: 20)
                            
                            Text(item)
                                .foregroundColor(.secondary)
                            
                        }
                    }
                }
            }
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isModalClosed: nil)
    }
}
