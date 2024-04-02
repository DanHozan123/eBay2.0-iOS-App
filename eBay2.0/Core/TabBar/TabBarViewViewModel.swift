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
    
    @Published var currentUser: User?
    
    private let authService = AuthentificationService.shared
    private let userDataManager = UserDataManager.shared
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        Task {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let user = await UserService.fetchUser(withUid: uid)
            userDataManager.currentUser = user
        }
        setupSubscribers()
    }
    
    func setupSubscribers() {
        UserDataManager.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &bag)
        
    }
    


    

    
    
    
}
