//
//  LaunchScreen.swift
//  ListMe
//
//  Created by Javra Software on 10/10/20.
//

import SwiftUI

struct LaunchScreen: View {
    
    var body: some View {
        TabView {
            ListCollectionView()
                .tabItem {
                    Image(systemName: "list.dash")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
