//
//  CustomPickerView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/4/20.
//

import SwiftUI

struct CustomPickerView: View {
    
    @State private var filterString: String = String()
    
    @State private var frameHeight: CGFloat = 400
    
    let items: [String]
    
    @Binding var presentPicker: Bool
    @Binding var pickerField: String
    
    let pickerTitle: String
    
    
    var body: some View {
        
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().backgroundColor = .clear
        
        return ZStack {
            
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Text(pickerTitle)
                        .padding(20)
                        .padding(.leading, 5)
                    Spacer()
                }
                .foregroundColor(Color.black.opacity(0.4))
                .background(Color.white)
                
                
                ZStack {
                    Color.white
                    
                    List {
                        ForEach(items, id:\.self) { item in
                            Button(action: {
                                pickerField = item
                                withAnimation {
                                    presentPicker = false
                                }
                            }, label: {
                                HStack {
                                    Text(item)
                                        .padding(.top, 7)
                                        .padding(.bottom, 7)
                                    Spacer()
                                    
                                    if pickerField == item {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                            .offset(x: 10)
                                    }
                                    
                                    
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxWidth: 320)
                    .padding(.trailing, 15)
                    .background(Color.white)
                    .onAppear(perform: {
                        setHeight()
                    })
                }
            }
            
            .cornerRadius(20)
            .frame(maxWidth: 380)
            .padding(20)
            .frame(height: frameHeight)
            .padding(.top, 40)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    fileprivate func setHeight() {
            //withAnimation {
                if items.count > 5 {
                    frameHeight = 400
                } else if items.count == 0 {
                    frameHeight = 130
                } else {
                    frameHeight = CGFloat(items.count * 45 + 130)
                }
            //}
        }
}

struct CustomPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerView(items: [""], presentPicker: .constant(false), pickerField: .constant(""), pickerTitle: "Demo")
    }
}
