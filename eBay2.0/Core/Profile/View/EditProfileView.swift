//
//  EditProfileView.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State private var imagePickerPresented = false
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
      
    }

    var body: some View {
        
        VStack(spacing: 20) {
    
            Button {
                imagePickerPresented.toggle()
            } label: {
                
                if let profileImageSelected = viewModel.profileImage {
                    profileImageSelected
                        .resizable()
                        .scaledToFill()
                        .frame(width: 84, height: 84)
                        .clipShape(Circle())
                }
                else if let profileImageLink = viewModel.user.profileImageLink {
                    KFImage(URL(string: profileImageLink))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 84, height: 84)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "plus.circle")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .tint(.black)
                        .frame(width: 84, height: 84)
                        .clipShape(Circle())
                }
            }
            
            VStack(alignment: .leading) {
                Text("You may change your name.")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                TextField(viewModel.user.fullname, text: $viewModel.profileChangedName)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.uploadData()
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    DoneButton()
                }
            }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)

    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_DATA)
    }
}
