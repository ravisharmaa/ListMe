//
//  LaunchScreen.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/10/20.
//

import SwiftUI

struct LaunchScreen: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            ListCollectionView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "list.dash")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(isLoggedIn: .constant(false))
    }
}
