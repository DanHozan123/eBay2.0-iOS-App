//
//  Products.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct ProductsView: View {
    
    var category: Category
    
    @Environment(\.presentationMode) var presentationMode
   
    @StateObject var viewModel: ProductsViewModel
    
    init(category: Category){
        self.category = category
        self._viewModel = StateObject(wrappedValue: ProductsViewModel(category: category))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(viewModel.products){ product in
                    NavigationLink(destination: ProductDetailView(product: product), label: { ProductCellView(product: product) })
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(category.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: { Image(systemName: "chevron.left") })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: { AddProductView(category: category) }, label: { Image(systemName: "plus") })
            }
        }
        .tint(.black)
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: Category.hardcodedProductCategories[2])
    }
}
