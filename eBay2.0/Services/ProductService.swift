//
//  ProductService.swift
//  eBay2.0
//
//  Created by Dan Hozan on 02.04.2024.
//

import Foundation
import FirebaseAuth
import Firebase

struct ProductService {
    
    
    @MainActor
    static func checkIfIsAddedToFavorites(productId: String) async -> Bool {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return false}
            let snapshot = try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(productId).getDocument()
            return snapshot.exists
        } catch {
            print("ERROR ", error.localizedDescription)
            return false
        }
    }
    
    @MainActor
    static func addToFavorites(productId: String) async {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return }
            try await FirebaseReferenceCollection(collectionReferance: .products).document(productId).collection(PRODUCT_USER_FAVORITES).document(uid).setData([:])
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(productId).setData([:])
        } catch {
            print("ERROR ", error.localizedDescription)
        }
    }
    
    @MainActor
    static func removeFromFavorites(productId: String) async {
        do {
            guard let  uid = Auth.auth().currentUser?.uid else { return }
            try await FirebaseReferenceCollection(collectionReferance: .products).document(productId).collection(PRODUCT_USER_FAVORITES).document(uid).delete()
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).collection(USER_PRODUCT_FAVORITES).document(productId).delete()
        } catch {
            print("ERROR ", error.localizedDescription)
        }
    }
    
    @MainActor
    static func fetchAllProducts() async -> [Product]? {
        do {
            return try await FirebaseReferenceCollection(collectionReferance: .products).getDocuments().documents.compactMap({ try? $0.data(as: Product.self) })
        } catch {
            print("ERROR: ", error.localizedDescription)
            return nil
        }
    }
    
}
