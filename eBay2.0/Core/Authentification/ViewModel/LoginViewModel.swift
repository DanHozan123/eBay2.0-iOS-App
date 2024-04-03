//
//  LoginViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    private let userDataManager = UserDataManager.shared
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    var isFormValid: Bool {
        return email != "" && password != ""
    }
    
    func login() async throws {
        let result = try await AuthentificationService.loginUser(withEmail: email, password: password)
        let user = await UserService.fetchUser(withUid: result.user.uid)
        userDataManager.currentUser = user
    }
}
