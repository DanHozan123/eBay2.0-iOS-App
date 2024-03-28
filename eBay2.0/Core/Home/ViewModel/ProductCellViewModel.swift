//
//  ProductCellViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 28.03.2024.
//

import Foundation
import Firebase

class ProductCellViewModel: ObservableObject {

    @Published var product: Product
    @Published var isAddedToFavorites = false
    
    init(product: Product) {
        self.product = product
        Task {
            await checkIfIsAddedToFavorites()
        }
    }
    
    @MainActor
    func checkIfIsAddedToFavorites() async {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(product.id).getDocument()
            
            if snapshot.exists {
                self.isAddedToFavorites = true
            }
        } catch {
            print("ERROR ", error.localizedDescription)
        }
    }
    
    @MainActor
    func addToFavorites() async {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return }
            try await FirebaseReferenceCollection(collectionReferance: .products).document(product.id).collection(PRODUCT_USER_FAVORITES).document(uid).setData([:])
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(product.id).setData([:])
            self.isAddedToFavorites = true
        } catch {
            print("ERROR ", error.localizedDescription)
        }
    }
    
    @MainActor
    func removeFromFavorites() async {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return }
            try await FirebaseReferenceCollection(collectionReferance: .products).document(product.id).collection(PRODUCT_USER_FAVORITES).document(uid).delete()
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(product.id).delete()
            self.isAddedToFavorites = false
        } catch {
            print("ERROR ", error.localizedDescription)
        }
    }
    
}
