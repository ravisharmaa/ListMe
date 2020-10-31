//
//  DemoView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/21/20.
//

import SwiftUI

struct DemoView: View {
    
    let layout = [
        GridItem(.flexible())
    ]
    
    @Binding var cartItems: [CartItem]
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            LazyVGrid(columns: layout, spacing: 0) {
                ForEach(cartItems, id: \.self) { item in
                    ZStack {
                        VStack(spacing: -3) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text("Create")
                                        .font(.footnote)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                }
                                //.padding(.leading, 30)
                                
                                Spacer()
                                Spacer()
                                
                                HStack {
                                    Capsule(style: .continuous)
                                        .padding()
                                        .frame(width: 70, height: 70)
                                        //.foregroundColor(Color.white.opacity(0.4))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).opacity(0.3))
                                        .overlay(
                                            Text(item.productCount.description)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.leading)
                                        )
                                        
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.8))
                                        .padding(.trailing, 10)
                                }
//                                .padding(.trailing, 20)
                            }
                            
                            Divider()
                        }
                        .padding()
                        .padding(.top, 15)
                        
                       
                    }
                    .frame(height: 75)
                    .padding(.horizontal, 10)
                }
            }
        }
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView(cartItems: .constant([]))
    }
}
