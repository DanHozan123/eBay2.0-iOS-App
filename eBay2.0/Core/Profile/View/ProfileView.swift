//
//  Profile.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import SwiftUI
import Kingfisher


struct ProfileView: View {
    
    @State private var isShowingAuthentificationForm = false
    
    @StateObject var viewModel: ProfileViewModel
    
    init(user: User?) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }

    var body: some View {
        
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    
                    if let user = viewModel.user {
                        Group {
                            NavigationLink(destination: EditProfileView(user: user), label: { Text("Edit Profile") })
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
                .padding(.leading, 20)
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    if let imageLink = viewModel.user?.profileImageLink, let url = URL(string: imageLink) {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person")
                            .font(.title2)
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let _ = viewModel.user {
                        Button {
                            viewModel.signOut()
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
            .navigationTitle(viewModel.user?.fullname ?? "Guest User")
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
    }
}


