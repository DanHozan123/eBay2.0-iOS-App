//
//  ProductDetailViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 27.03.2024.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
   
    @Published var product: Product
    @Published var productOwner: User?
    
    
    init(product: Product) {
        self.product = product
        Task {
            if let owner = await fetchProductOwner() {
                DispatchQueue.main.async {
                    self.productOwner = owner
                }
            }
        }
    }
    
    func fetchProductOwner() async -> User? {
        if let owner = await UserService.fetchUser(withUid: product.ownerId) {
            return owner
        }
        return nil
    }
    
}
