//
//  ContentViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import FirebaseAuth
import Combine


class TabBarViewViewModel: ObservableObject {
    
    
    private let prodcutDataManager = ProductDataManager.shared
    private let userDataManager = UserDataManager.shared
    private var bag = Set<AnyCancellable>()
    
    @Published var currentUser: User?
 
    
    init() {
        Task {
            await updateUserDataManager()
            await updateProductDataManager()
        }
        setupSubscribers()
    }
    
    func setupSubscribers() {
        UserDataManager.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &bag)
        
    }
    
    func updateUserDataManager() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let user = await UserService.fetchUser(withUid: uid)
        userDataManager.currentUser = user
    }

    func updateProductDataManager() async {
        
        guard let products = await ProductService.fetchAllProducts() else { return }
        prodcutDataManager.allProducts = products
        
        var addedToFavoritesProduct = Set<Product>()
        for product in products {
            if await ProductService.checkIfIsAddedToFavorites(productId: product.id) {
                addedToFavoritesProduct.insert(product)
            }
        }
        prodcutDataManager.addedToFavoritesProducts = addedToFavoritesProduct
    }
    
    
}
