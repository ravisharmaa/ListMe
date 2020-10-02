//
//  ListView.swift
//  ListMe
//
//  Created by Javra Software on 10/2/20.
//

import SwiftUI

struct ListView: View {
    
    @State var isPresented: Bool = false
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        
        NavigationView {
            Text("Welcome")
                .font(.largeTitle)
                .navigationBarTitle("Lists")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            isPresented.toggle()
                                        }, label: {
                                            Image(systemName: "plus").font(.title)
                                        }).sheet(isPresented: $isPresented, content: {
                                            ListForm(isPresented: $isPresented)
                                        })
                )
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
