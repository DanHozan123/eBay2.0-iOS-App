//
//  ProductDataManager.swift
//  eBay2.0
//
//  Created by Dan Hozan on 02.04.2024.
//

import Foundation

class ProductDataManager {
    
    static let shared = ProductDataManager()
    
    @Published var currentCategoryFiltredProducts = [Product]()
    @Published var addedToFavoritesProducts = [Product]()
    
    func addProductToCurrentCategoryFiltredProducts(product: Product) {
        self.currentCategoryFiltredProducts.append(product)
    }

    private init() {}
}
