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
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            //
        }, label: {
            Image(systemName: "chevron.left").font(.title2)
        }))
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView()
    }
}
