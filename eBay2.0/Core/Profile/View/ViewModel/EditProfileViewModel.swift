//
//  EditProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 26.03.2024.
//

import Foundation
import PhotosUI
import SwiftUI
 
class EditProfileViewModel: ObservableObject {
    
    private let userDataManager = UserDataManager.shared
    private var uiImage: UIImage?
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage)} }
    }
    @Published var user: User
    @Published var profileChangedName = ""
    @Published var profileImage: Image?

    
    init(user: User) {
        self.user = user
    }
    
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    func uploadData() async {
        do {
            var data = [String: Any]()
            
            if let uiImage = uiImage {
                let imageUrl = await ImageService.uploadImage(image: uiImage, imagePath: ImagePath.profile_images)
                data["profileImageLink"] = imageUrl
                self.user.profileImageLink = imageUrl
            }
            
            if user.fullname != profileChangedName && profileChangedName != "" {
                data["fullname"] = profileChangedName
                self.user.fullname = profileChangedName
            }
            
            if !data.isEmpty {
                try await FirebaseReferenceCollection(collectionReferance: .users).document(user.id).updateData(data)
                userDataManager.currentUser = user
            }
            
            
        }
        catch{
            print("ERROR: ", error.localizedDescription)
        }

        
    }
}
