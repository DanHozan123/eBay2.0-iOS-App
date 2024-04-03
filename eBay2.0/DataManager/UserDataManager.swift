//
//  UserDataManager.swift
//  eBay2.0
//
//  Created by Dan Hozan on 02.04.2024.
//

import Foundation

class UserDataManager {
    
    static let shared = UserDataManager()
    
    @Published var currentUser: User?
    
    func setCurrentUser( user: User) {
        self.currentUser = user
    }
 
    private init() {}
}
