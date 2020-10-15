//
//  FloatingTextField.swift
//  ListMe
//
//  Created by Javra Software on 10/11/20.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    let height: CGFloat
    let isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : Color.gray)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -20)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.75, anchor: .leading)
                .font(.subheadline)
                .padding()
                
            
            
            if isSecure {
                SecureField("", text: text)
                    .padding()
                    //.border(Color.blue)
                    .padding(.top, 8)
                    
            } else {
                TextField("", text: text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .padding(.top, 8)
                    
                    
            }
                
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .padding(.top, 15)
        .animation(.spring(response: 0.4, dampingFraction: 0.6))
        .padding()
        
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(title: "Enter Email", text: .constant("Hello"), height: 50, isSecure: false)
    }
}
