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
    @Published var addedToFavoritesProducts = [Product]()
    
    private init() {
    }
    
    func addProductToCurrentCategoryFiltredProducts(product: Product) {
        self.currentCategoryFiltredProducts.append(product)
    }
    
    func removeAddedToFavoriteProduct(product: Product) {
        if let index = addedToFavoritesProducts.firstIndex(of: product) {
            addedToFavoritesProducts.remove(at: index)
        }
    }
    
    func addAddedToFavoriteProduct(product: Product) {
        addedToFavoritesProducts.append(product)
    }
    
    
}
