//
//  SearchViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 28.03.2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {

    private var bag = Set<AnyCancellable>()
    private let productManager = ProductDataManager.shared
    
    @Published var products = [Product]()
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        productManager.$allProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] allProducts in
                self?.products = allProducts
            }
            .store(in: &bag)
    }
    
    
    @MainActor
    func fetchProducts(inputSearchbar: String) -> [Product] {
        return  products.filter({ $0.title.lowercased().contains(inputSearchbar.lowercased()) || $0.features.lowercased().contains(inputSearchbar.lowercased()) })
    }
    
    
}
