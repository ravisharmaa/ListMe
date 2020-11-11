//
//  LaunchScreen.swift
//  ListMe
//
//  Created by Ravi Bastola Software on 10/10/20.
//

import SwiftUI

struct LaunchScreen: View {
    
    enum TabSelection {
        case ListTab
        case ProfileTab
    }
    
    @Binding var isLoggedIn: Bool
    
    @State private var tabSelection: TabSelection = .ListTab
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                ListCollectionView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "list.dash")
                    }.tag(TabSelection.ListTab)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(TabSelection.ProfileTab)
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(isLoggedIn: .constant(false))
    }
}
