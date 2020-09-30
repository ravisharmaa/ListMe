//
//  MainRegistrationForm.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/28/20.
//

import SwiftUI

struct MainRegistrationForm: View {
    
    @State private var slideGesture: CGSize = .zero
    
    @State private var isFirstScreenSlided: Bool = false
    
    @State private var isSecondScreenSlided: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            DetailForm()
                .offset(x: slideGesture.width)
                .offset(x: isFirstScreenSlided ? 0 : 500)
                .offset(x: isSecondScreenSlided ? 500 : 0 )
                .animation(.spring())
                .gesture(
                    DragGesture().onChanged({ (changed) in
                        slideGesture = changed.translation
                    
                    }).onEnded({ (ended) in
                        if slideGesture.width < -150 {
                            isFirstScreenSlided = true
                            isSecondScreenSlided = true
                        }
                        
                        if slideGesture.width > 150 {
                            isSecondScreenSlided = false
                            isFirstScreenSlided = true
                        }
                        
                        
                        slideGesture = .zero
                    })
                )
            
            
            UserRegistrationForm()
                .offset(x: slideGesture.width)
                .offset(x: isFirstScreenSlided ? -500 : 0)
                .gesture(
                    DragGesture().onChanged({ (changed) in
                        slideGesture = changed.translation
                    
                    }).onEnded({ (ended) in
                        if slideGesture.width < -150 {
                            isFirstScreenSlided = true
                            isSecondScreenSlided = false
                        }
                        
                        slideGesture = .zero
                    })
                )
            
           
            VStack {
                Spacer().frame(height: 450)
                
                ZStack {
                    Text("Next")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.white)
                }
                .frame(width: 149, height: 45)
                .background(Color.black)
                .cornerRadius(20)
            }
        }
    }
}

struct MainRegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        MainRegistrationForm()
    }
}
