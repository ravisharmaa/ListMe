//
//  CartView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/4/20.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        
        ZStack {
           
            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
            
            HStack {
                VStack(alignment: .leading){
                    Text("Hello world")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Sept 20, 2020")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    Text("Hello world")
                        .padding(.top, 1)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                Capsule(style: .continuous)
                    .padding()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.4))
                    .overlay(
                        Text("999")
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    )
                    
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.8))
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
