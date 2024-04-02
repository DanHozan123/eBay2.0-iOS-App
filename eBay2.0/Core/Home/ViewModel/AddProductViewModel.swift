//
//  AddProductViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 26.03.2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class AddProductViewModel: ObservableObject {
    
    private var uiImage: UIImage?
    private let productDataManager = ProductDataManager.shared
    
    @Published var productImage: Image?
    @Published var title = ""
    @Published var condition = ""
    @Published var price = ""
    @Published var features = ""
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage)} }
    }
    
    var formValidation: Bool {
        return title != "" && condition != "" && price != "" && features != "" && uiImage != nil
    }
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.productImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    func uploadProduct(productCategory: ProductCategory) async {
        do {
            guard let uiImage = self.uiImage else { return }
            let imageLink = await ImageService.uploadImage(image: uiImage, imagePath: .products_images)
            guard let imageProductLink = imageLink else { return }
            
            guard let ownerId = Auth.auth().currentUser?.uid else { return }
            let productId = UUID().uuidString
            
            let product = Product(id: productId, ownerId: ownerId, title: title, condition: condition, price: (Float(price) ?? 0.0), features: features, productImageLink: imageProductLink, timestamp: Date(), category: productCategory)
            guard let encodedProduct = try? Firestore.Encoder().encode(product) else { return }
            
            
            try await FirebaseReferenceCollection(collectionReferance: .products).document(productId).setData(encodedProduct)
            productDataManager.addProductToCurrentCategoryFiltredProducts(product: product)
            
            
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
}
