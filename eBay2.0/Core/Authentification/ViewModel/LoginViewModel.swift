//
//  LoginViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    var authService = AuthentificationService.shared
    
    var isFormValid: Bool {
        return email != "" && password != ""
    }
    
    func login() async throws {
        try await authService.loginUser(withEmail: email, password: password)
    }
}
