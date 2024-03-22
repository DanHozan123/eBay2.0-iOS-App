//
//  ContentViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import FirebaseAuth
import Combine

class TabBarViewViewModel: ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        AuthentificationService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        AuthentificationService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
    }
    
}
