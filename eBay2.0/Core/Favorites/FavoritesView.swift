//
//  FavoritesView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product), label: { ProductCellView(product: product) })
                        
                    }
                }
            }
            .navigationBarTitle("Favorites")
            .tint(.black)
        }
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
