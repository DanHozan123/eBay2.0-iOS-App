//
//  EditProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 25.03.2024.
//

import Foundation
import PhotosUI
import SwiftUI

class EditProfileViewModel: ObservableObject {
    
    let user: User
    
    @Published var name = ""
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage)} }
    }
    
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        self.name = user.fullname
    }
    
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    
    func uploadData() async {
        do {
            var data = [String: Any]()
            
            if let uiImage = uiImage {
                let imageUrl = await ImageUploader.uploadImage(image: uiImage)
                data["profileImageLink"] = imageUrl
            }
            
            if user.fullname != name {
                data["fullname"] = name
            }
            
            if data.isEmpty == false {
                try await FirebaseReferenceCollection(collectionReferance: .users).document(user.id).updateData(data)
            }
            
        }
        catch{
            print("ERROR: ", error.localizedDescription)
        }
        
    }
    
    
    
}
