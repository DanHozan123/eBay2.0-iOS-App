//
//  Profile.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI

enum OptionList: String {
    
    case EditPorfile = "Edit Profile"
    case Cart = "Cart"
    case Favorites = "Favorites"
    case History = "Purchase History"
    case TermsOfService = "Terms of Service"
    case SuspendAccount = "Suspend Account"
    case DeleteAccount = "Delete Account"
    
}


struct ProfileView: View {
    
    @State private var isShowingAuthentificationForm = false
    @StateObject var viewModel = ProfileViewModel()
    
    let user: User?
    
    
    var body: some View {
        
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    
                    if let _ = user {
                        Group {
                            NavigationLink(destination: EditProfileView(), label: { Text("EditProfile") })
                            Text("Cart")
                            Text("Favorites")
                            Text("Purchase History")
                            Text("Terms of Service")
                        }
                        .font(.title2)
                        .foregroundColor(.black)
                        
                        Divider()
                        
                        Group {
                            Text("Suspend Account")
                            Text("Delete Account")
                        }
                        .font(.title2)
                        .foregroundColor(.red)
                    }
                    else {
                        InactiveButtonsExtractedView()
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, 10)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if let user = user {
                            if let imageLink = user.profileImageLink {
                                Image(imageLink)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                            else {
                                Image(systemName: "person")
                                    .font(.title2)
                            }
                            
                        } else {
                            Image(systemName: "person")
                                .font(.title2)
                                
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if let _ = user {
                            Button {
                                viewModel.singOut()
                            } label: {
                                Text("Sign Out")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                            }
                        } else {
                            Button {
                                isShowingAuthentificationForm.toggle()
                            } label: {
                                Text("Sign In")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .navigationTitle(user?.fullname ?? "Guest User")
                .padding(.leading, 20)
                Spacer()
                
            }
            .fullScreenCover(isPresented: $isShowingAuthentificationForm) {
                LoginView(isShowingAuthentificationForm: $isShowingAuthentificationForm)
            }
        }
    }
}

struct InactiveButtonsExtractedView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text("Edit Profile")
                Text("Cart")
                Text("Favorites")
                Text("Purchase History")
                Text("Terms of Service")
            }
            .font(.title2)
            
            Divider()
            
            Group {
                Text("Suspend Account")
                Text("Delete Account")
            }
            .font(.title2)
            .foregroundColor(.red)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_DATA)
        //ProfileView(user: nil)
    }
}


