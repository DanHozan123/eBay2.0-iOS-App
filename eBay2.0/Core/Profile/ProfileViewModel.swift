//
//  ProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func signOut() {
        AuthentificationService.shared.signOut()
    }
    
}
