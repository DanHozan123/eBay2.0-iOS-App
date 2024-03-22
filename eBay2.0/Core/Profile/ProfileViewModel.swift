//
//  ProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    func singOut()  {
         AuthentificationService.shared.signOut()
    }
    
}
