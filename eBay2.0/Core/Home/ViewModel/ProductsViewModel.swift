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
    
    
    @Published var products = [Product]()
    
    private var cancellables = Set<AnyCancellable>()
    private var category: Category
    
    init(category: Category){
        self.category = category
        Task {
            await fetchProducts()
        }
        setupSubscribers()
    }
    
    func setupSubscribers() {
        ProductAdded.shared.addedProductToList.sink { [weak self] productAdded in
            guard let self = self else { return }
            if productAdded {
                Task {
                    await self.fetchProducts()
                }
                ProductAdded.shared.addedProductToList.send(false)
            }
        }
        .store(in: &cancellables)
    }

    
    
    @MainActor
    func fetchProducts() async{
        do {
            
            let querySnapshot = try await FirebaseReferenceCollection(collectionReferance: .products)
                .whereField("category", isEqualTo: category.category.rawValue)
                .getDocuments()
            
            let products = querySnapshot.documents.compactMap({ try? $0.data(as: Product.self) })
            self.products = products
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
        
    }
    
}
