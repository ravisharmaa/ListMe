//
//  LaunchTabView.swift
//  ListMe
//
//  Created by Javra Software on 10/9/20.
//

import SwiftUI

struct LaunchTabView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> LaunchViewController {
        return LaunchViewController()
    }
    
    func updateUIViewController(_ uiViewController: LaunchViewController, context: Context) {
        //
    }
    
    
    typealias UIViewControllerType = LaunchViewController
}

struct LaunchTabView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchTabView()
    }
}
