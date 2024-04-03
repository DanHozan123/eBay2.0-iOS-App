//
//  ProductCellViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 28.03.2024.
//

import Foundation
import Firebase
import Combine

class ProductCellViewModel: ObservableObject {

    let productDataManager = ProductDataManager.shared
    
    @Published var product: Product
    @Published var isAddedToFavorites = false
    
    private var bag = Set<AnyCancellable>()

    
    init(product: Product) {
        self.product = product
        setupSubscribers()

    }

    func setupSubscribers() {
        productDataManager.$addedToFavoritesProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] added in
                self?.checkIfIsAddedToFavorites()
            }
            .store(in: &bag)
        
    }
  
    func checkIfIsAddedToFavorites(){
        if productDataManager.addedToFavoritesProducts.contains(product) {
            self.isAddedToFavorites = true
        } else {
            self.isAddedToFavorites = false
        }
    }
    
    @MainActor
    func addToFavorites() async {
        await ProductService.addToFavorites(productId: product.id)
        productDataManager.addAddedToFavoriteProduct(product: product)
        
    }
    
    @MainActor
    func removeFromFavorites() async {
        await ProductService.removeFromFavorites(productId: product.id)
        productDataManager.removeAddedToFavoriteProduct(product: product)
    }
    
}
