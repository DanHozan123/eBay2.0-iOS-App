//
//  AuthentificationViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var password: String = ""
    
    private let authService = AuthentificationService.shared
    private let userDataManager = UserDataManager.shared
    
    var isFormValid: Bool {
        return email != "" && fullname != "" && password != ""
    }
    
    func registerUser() async throws {
        let user = try await authService.createUser(withEmail: email, fullname: fullname, password: password)
        userDataManager.currentUser = user
    }
    
    
    
    
}
