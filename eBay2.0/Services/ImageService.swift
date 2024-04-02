//
//  ImageUploader.swift
//  eBay2.0
//
//  Created by Dan Hozan on 25.03.2024.
//


import FirebaseStorage
import UIKit

enum ImagePath: String {
    case profile_images
    case products_images
}


struct ImageService {
    
    static func uploadImage(image: UIImage, imagePath: ImagePath) async -> String? {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        
        let imageName = UUID().uuidString
        let ref = Storage.storage().reference().child(imagePath.rawValue).child(imageName)
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Error uploading image:", error.localizedDescription)
            return nil
        }
    }
}
