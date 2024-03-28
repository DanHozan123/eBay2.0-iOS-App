//
//  SearchView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(searchText.isEmpty ? viewModel.products: viewModel.fetchProducts(inputSearchbar: searchText)) { product in
                        NavigationLink(destination: ProductDetailView(product: product), label: { ProductCellView(product: product) })
                    }
                }
                .navigationTitle("Explore")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, prompt: "Search...")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
