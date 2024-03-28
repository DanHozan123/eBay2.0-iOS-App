//
//  SearchViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 28.03.2024.
//

import Foundation


class SearchViewModel: ObservableObject {

    
    @Published var products = [Product]()
    
    
    init() {
        Task { await fetchAllProducts() }
    }
    
    @MainActor
    func fetchAllProducts() async {
        do {
            self.products = try await FirebaseReferenceCollection(collectionReferance: .products).getDocuments().documents.compactMap({ try? $0.data(as: Product.self) })
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
    
    @MainActor
    func fetchProducts(inputSearchbar: String) -> [Product] {
        return  products.filter({ $0.title.lowercased().contains(inputSearchbar.lowercased()) || $0.features.lowercased().contains(inputSearchbar.lowercased()) })
    }
    
    
}
