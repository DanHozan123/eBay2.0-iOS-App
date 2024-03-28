//
//  ProductCellView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI
import Kingfisher

struct ProductCellView: View {
    
    private let dimension = (UIScreen.main.bounds.width / 2.5)
    
    @StateObject var viewModel: ProductCellViewModel
    
    init(product: Product){
        self._viewModel = StateObject(wrappedValue: ProductCellViewModel(product: product))
    }
    
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: viewModel.product.productImageLink))
                    .resizable()
                    .scaledToFill()
                    .frame(width: dimension, height: dimension)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    
                    Spacer()
                    
                    Text(viewModel.product.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text(viewModel.product.condition)
                        .font(.subheadline)
                        .textCase(.uppercase)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack {
                        Text(viewModel.product.formattedPrice)
                            .font(.title)
                        
                        Spacer()
                        
                        Button {
                            Task {
                                if viewModel.isAddedToFavorites {
                                    await viewModel.removeFromFavorites()
                                } else {
                                    await viewModel.addToFavorites()
                                }
                            }
                        } label: {
                            Image(systemName: viewModel.isAddedToFavorites ? "heart.fill" : "heart" )
                                .tint(.black)
                        }
                    }
                    Spacer()
                    
                }
                Spacer()
            }
            .frame(height: dimension)
            Divider()
        }
        
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product.MOCK_DATA[0])
    }
}
