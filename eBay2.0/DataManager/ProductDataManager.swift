//
//  ProductDataManager.swift
//  eBay2.0
//
//  Created by Dan Hozan on 02.04.2024.
//

import Foundation

class ProductDataManager {
    
    static let shared = ProductDataManager()
    
    @Published var allProducts = [Product]()
    @Published var currentCategoryFiltredProducts = [Product]()
    @Published var addedToFavoritesProducts: Set<Product> = []
    
    private init() {
    }
    
    func addProductToCurrentCategoryFiltredProducts(product: Product) {
        self.currentCategoryFiltredProducts.append(product)
    }
    
    func removeAddedToFavoriteProduct(product: Product) {
        addedToFavoritesProducts.remove(product)
        print(addedToFavoritesProducts.count)
    }
    
    func addAddedToFavoriteProduct(product: Product) {
        addedToFavoritesProducts.insert(product)
        print(addedToFavoritesProducts.count)
    }

    
}
