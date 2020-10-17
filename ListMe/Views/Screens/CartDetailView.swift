//
//  CartDetailView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/17/20.
//

import SwiftUI

struct CartDetailView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    NavigationLink(
                        destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                        label: {
                            /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                        })
                }
            }
        }
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView()
    }
}
