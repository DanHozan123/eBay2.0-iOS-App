//
//  Products.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct ProductsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var category: Category
    var products: [Product]
    
    init(category: Category) {
        self.category = category
        self.products = Product.MOCK_DATA.filter { $0.category == category.category }
    }
    
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(products){ product in
                    ProductCellView(product: product)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(category.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: Category.hardcodedProductCategories[2])
    }
}
