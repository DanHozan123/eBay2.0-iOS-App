//
//  ProductDetail.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    
    private let dimension = (UIScreen.main.bounds.width / 2)
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ProductDetailViewModel
    
    init(product: Product) {
        self._viewModel = StateObject(wrappedValue: ProductDetailViewModel(product: product))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                
                KFImage(URL(string: viewModel.product.productImageLink))
                    .resizable()
                    .scaledToFit()
                    .frame(width: dimension, height: dimension)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 10) {

                    Text(viewModel.product.title)
                        .font(.title3)
                        .fontWeight(.semibold)
          
                    HStack() {
                        KFImage(URL(string: viewModel.productOwner?.profileImageLink ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        Text(viewModel.productOwner?.fullname ?? "")
                            .fontWeight(.semibold)
                    }
           

                    HStack() {
                        Text("Condition:")
                            .fontWeight(.semibold)
                        Text(viewModel.product.condition)
                    }
                
                    HStack() {
                        Text("Price:")
                            .fontWeight(.semibold)
                        Text(viewModel.product.formattedPrice)
                    }
                    Divider()

                    VStack(alignment: .leading) {
                        Text("Fetures:")
                            .fontWeight(.semibold)
                        Text(viewModel.product.features)
                    }
                    
                    Divider()

                    
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Product Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }, label: { Image(systemName: "chevron.left") })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("add to cart")
                    } label: {
                        Image(systemName: "cart")
                    }
                }
            }
            .tint(.black)
        }
    }
    
}


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.MOCK_DATA[0])
    }
}
