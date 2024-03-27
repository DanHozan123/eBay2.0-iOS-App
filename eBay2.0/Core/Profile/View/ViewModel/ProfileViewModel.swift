//
//  ProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import Combine


class ProfileViewModel: ObservableObject {
    
    
    @Published var user: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User?) {
        self.user = user
        setupSubscribers()
    }
    
    func setupSubscribers() {
        ProfileUpdate.shared.changedUser.sink { [weak self] user in
            self?.user = user
        }
        .store(in: &cancellables)
    }
    
    
    func signOut() {
        AuthentificationService.shared.signOut()
    }
    
    
}
