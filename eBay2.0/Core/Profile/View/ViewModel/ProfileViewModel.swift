//
//  ProfileViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import Combine


class ProfileViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let userDataManager = UserDataManager.shared
    
    @Published var user: User?
    
    init(user: User?) {
        self.user = user
        setupSubscribers()
    }
    
    func setupSubscribers() {
        userDataManager.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
            self?.user = user
        }
        .store(in: &cancellables)
    }
    
    
    func signOut() {
        AuthentificationService.signOut()
        userDataManager.currentUser = nil
    }
    
    
}
