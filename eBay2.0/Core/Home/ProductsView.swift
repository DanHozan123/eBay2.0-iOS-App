//
//  Products.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct ProductsView: View {
    
    var category: Category
    var products: [Product] = {
        return Product.MOCK_DATA.filter({ $0.category == ProductCategory.CellPhonesAndAccessories })
    }()
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(products){ product in
                    ProductCellView(product: product)
                }
            }
        }
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: Category.categories[2])
    }
}
