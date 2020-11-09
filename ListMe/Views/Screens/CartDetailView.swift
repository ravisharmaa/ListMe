//
//  CartDetailView.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/17/20.
//

import SwiftUI
import CodeScanner
import Introspect


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
            }.disabled(cartItem.completedAt != nil ? true : false)
            
            Button(action: {
                searchViewShown.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
            })
            .padding(.trailing, 5)
            .sheet(isPresented: $searchViewShown, content: {
                SearchView(isSearchShown: $searchViewShown, viewModel: viewModel, cart: cartItem)
            }).disabled(cartItem.completedAt != nil ? true : false)
            
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
    
   
    var infoView: some View {
        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(cartItem.name)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                HStack {
                    if cartItem.completedAt != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Confirmed")
                    }
                    
                    Spacer(minLength: 5)
                    
                    if viewModel.cartProducts.count == 0 {
                        Text("\(cartItem.productCount.description) \(cartItem.productCount <= 1 ? "Item ": "Items ")    \(cartItem.createdAt ?? "") ")
                        
                    } else {
                        Text("\(viewModel.cartProducts.count.description) \(viewModel.cartProducts.count <= 1 ? "Item ": "Items ") \(cartItem.createdAt ?? "") ")
                        
                    }
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.subheadline)
            }
            .padding(.leading, 20)
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 30)
    }
    
    @State var showProductActions: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    headingView
                    infoView
                    CardDetailItemView(cartProducts: viewModel.cartProducts)
                        .onTapGesture {
                            showProductActions.toggle()
                        }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                
            }
            
            if showProductActions {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 275)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        // upper section
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Gatorade")
                                    .font(.title)
                                Text("Berry Variety Pack")
                                    .font(.subheadline)
                                Text("12oz/28pk")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("1")
                                    .font(.title)
                                
                                Text("Pack")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Gatorade")
                                    .font(.title)
                                Text("Berry Variety Pack")
                                    .font(.subheadline)
                                Text("12oz/28pk")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("1")
                                    .font(.title)
                                
                                Text("Pack")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer()
                            .frame(height: 80)
                        
                    }
                    .padding()
                }
                .offset(x: 0, y: showProductActions ? 300 : 0)
                .edgesIgnoringSafeArea(.all)
            }
            
            
            
        }
        .onAppear(perform: {
            viewModel.fetchProductOf(cart: cartItem)
            UITabBar.appearance().isHidden = true
        })
        .navigationTitle("Hello")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .introspectTabBarController { (tabBarController) in
            tabBarController.tabBar.isHidden = showProductActions
        }
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

struct CardDetailItemView: View {
    
    let layout = [
        GridItem(.flexible())
    ]
    
    let cartProducts: [Product]
    
    var body: some View {
        
        LazyVGrid(columns: layout, spacing: 12) {
            
            ForEach(cartProducts, id: \.self) { item in
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.11), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
                    
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
                            Text("\(item.quantity ?? 0) \(item.unit!)")
                        }
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                        
                    }
                }
                .frame(height: 100)
                .padding(.horizontal, 10)
            }.animation(.easeOut)
        }
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView(cartItem: .init(name: "Demo", supplierName: "Demo", storeName: "Demo", productCount: 0, completedAt: nil, createdAt: nil, slug: "slug"), viewModel: .init())
    }
}
