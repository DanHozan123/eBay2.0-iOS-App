//
//  ProductCellView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    private let dimension = (UIScreen.main.bounds.width / 2.5)

    var body: some View {
        HStack {
            Image(product.productImageLink)
                .resizable()
                .scaledToFill()
                .frame(width: dimension, height: dimension)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                
                Spacer()
                
                Text(product.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
                
                Text(product.condition)
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack {
                    Text(product.formattedPrice)
                        .font(.title)
                    
                    Spacer()
                    
                    Button {
                        print("favorites")
                    } label: {
                        Image(systemName: "heart")
                            .tint(.black)
                    }

                    
                }
                Spacer()
                    
            }
            Spacer()
        }
        .frame(width: .infinity, height: dimension)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product.MOCK_DATA[0])
    }
}
