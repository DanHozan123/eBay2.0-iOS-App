//
//  ProductsViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 26.03.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class ProductAdded {
    
    static let shared = ProductAdded()
    
    let addedProductToList = PassthroughSubject<Bool, Never>()
    
    private init() {}
}


class ProductsViewModel: ObservableObject {
    
    
    private var bag = Set<AnyCancellable>()
    private let category: Category
    private let productDataManager = ProductDataManager.shared
    
    @Published var products =  [Product]()
    

    init(category: Category){
        self.category = category
        Task {
            await fetchProductsWithCategory()
        }
        setupSubscribers()
    }
    
    
    func setupSubscribers() {
        productDataManager.$currentCategoryFiltredProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
            self?.products = products
        }
        .store(in: &bag)
    }

    
    @MainActor
    func fetchProductsWithCategory() async {
        do {
            
            let querySnapshot = try await FirebaseReferenceCollection(collectionReferance: .products)
                .whereField("category", isEqualTo: category.category.rawValue)
                .getDocuments()
            
            let products = querySnapshot.documents.compactMap({ try? $0.data(as: Product.self) })
            productDataManager.currentCategoryFiltredProducts = products
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
        
    }
    
}
