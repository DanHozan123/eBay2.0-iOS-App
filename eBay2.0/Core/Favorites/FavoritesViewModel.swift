//
//  FavoritesViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 04.04.2024.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
   
    private var bag = Set<AnyCancellable>()
    private let productDataManager = ProductDataManager.shared
    
    @Published var products =  [Product]()
    

    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        productDataManager.$addedToFavoritesProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
            self?.products = products
        }
        .store(in: &bag)
    }


}
