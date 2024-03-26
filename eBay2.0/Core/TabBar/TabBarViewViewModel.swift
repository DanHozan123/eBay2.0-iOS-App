//
//  ContentViewModel.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import FirebaseAuth
import Combine



class ProfileUpdate {
    
    static let shared = ProfileUpdate()
    
    let changedUser = PassthroughSubject<User, Never>()
    
    private init() {}
}


class TabBarViewViewModel: ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        
        // Authentification
        AuthentificationService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        AuthentificationService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
        
        //Profile
        ProfileUpdate.shared.changedUser.sink { [weak self] user in
                self?.currentUser = user
        }
        .store(in: &cancellables)
        
        
    }
    


    

    
    
    
}
