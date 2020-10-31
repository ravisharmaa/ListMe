//
//  CartDetailView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/17/20.
//

import SwiftUI
import CodeScanner


struct CustomMenuStyle: MenuStyle {
   
    func makeBody(configuration: Configuration) -> some View {
            Menu(configuration)
                .foregroundColor(.blue)
        }
    
    
}

struct CartDetailView: View {
    
    @Environment (\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var searchViewShown: Bool = false
    
    @State var showScanner: Bool = false
    
    let cartItem: CartItem
    
    @ObservedObject var viewModel: CartViewModel = CartViewModel()
    
    // MARK:- Navigation Bar View
    var navigationBarItemView: some View {
        return HStack(spacing: 15) {
            
            Button(action: {
                showScanner.toggle()
            }, label: {
                Image(systemName: "barcode.viewfinder")
            })
            .padding(.trailing, 5)
            .sheet(isPresented: $showScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "", completion: self.handleScan)
            }
            
            Button(action: {
                searchViewShown.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
            })
            .padding(.trailing, 5)
            .sheet(isPresented: $searchViewShown, content: {
                SearchView(isSearchShown: $searchViewShown, viewModel: viewModel, cart: cartItem)
            })
            
            Menu {
                Section {
                    Button(action: {
                        viewModel.confirmCart(cart: cartItem, userId: 1)
                    }) {
                        Text("Confirm List")
                        
                    }
                    
                    Button(action: {}) {
                       Text("Share")
                    }
                    
                    Button(action: {}) {
                       Text("Send to Supplier")
                    }
                    
                    Button(action: {
                        viewModel.clearProductsOf(cart: cartItem)
                    }) {
                        Text("Clear List")
                    }
                    
                    Button(action: {}) {
                        Text("Group By Supplier")
                    }
                }
                
                Section(header: Text("Secondary actions")) {
                    Button(action: {
                        viewModel.destroy(cart: cartItem)
                        mode.wrappedValue.dismiss()
                    }) {
                        Text("Delete")
                            .foregroundColor(.red)
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .menuStyle(BorderlessButtonMenuStyle())
            
            
        }
        .font(.title2)
    }
    
    // MARK:- Back Button View
    var backButtonView: some View {
        return Button(action: {
            mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left").font(.title2)
            
        })
    }
    
    //MARK:- Heading View
    var headingView: some View {
        HStack {
            backButtonView
            
            Spacer()
            navigationBarItemView
        }
    }
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    headingView
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(cartItem.name)
                                .font(.title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            
                            if viewModel.cartProducts.count == 0 {
                                Text("\(cartItem.productCount.description) \(cartItem.productCount <= 1 ? "Item": "Items")    Created: \(cartItem.createdAt ?? "") ")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            } else {
                                Text("\(viewModel.cartProducts.count.description) \(viewModel.cartProducts.count <= 1 ? "Item": "Items")    Created: \(cartItem.createdAt ?? "") ")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                    
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ForEach(viewModel.cartProducts, id: \.self) { item in
                                
                                ZStack {
                                    HStack(spacing: 5) {
                                        RoundedRectangle(cornerRadius: 10, style: .circular)
                                            .fill(Color.gray.opacity(0.4))
                                            .frame(height: 80)
                                            .frame(width: 70)
                                            .padding(.horizontal)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(item.name!)
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(item.flavour!)
                                                .fontWeight(.regular)
                                                .font(.caption)
                                            
                                            HStack {
                                                Text(item.weight!)
                                                    .foregroundColor(.gray)
                                                    .fontWeight(.regular)
                                                    .font(.caption)
                                                
                                                Text("In: \(item.category!)")
                                                    .foregroundColor(.gray)
                                                    .fontWeight(.regular)
                                                    .font(.caption)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        
                                        HStack {
                                            Button {
                                                viewModel.populate(add: false, product: item, toBasket: cartItem)
                                            } label: {
                                                Image(systemName: "minus.circle")
                                            }
                                            
                                            Button {
                                                viewModel.populate(add: true, product: item, toBasket: cartItem)
                                            } label: {
                                                Image(systemName: "plus.circle")
                                            }
                                        }
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                                        
                                    }
                                }
                                .frame(height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
                                )
                                .padding(.horizontal, 10)
                            }.animation(.easeOut)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear(perform: {
            viewModel.fetchProductOf(cart: cartItem)
        })
        .navigationTitle("Hello")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK:- Handles Scan
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        
        showScanner.toggle()
        switch result {
        case .success(let code):
            print(code)
        case .failure(let error):
            print(error)
        }
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView(cartItem: .init(name: "Demo", supplierName: "Demo", storeName: "Demo", productCount: 0, completedAt: nil, createdAt: nil, slug: "slug"), viewModel: .init())
    }
}
