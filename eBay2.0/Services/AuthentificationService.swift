//
//  AuthentificationService.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class AuthentificationService {

    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthentificationService()
    
    init() {
        Task {
            await loadUserData()
        }
    }

    @MainActor
    func loginUser(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        await loadUserData()
    }
    
    @MainActor
    func createUser(withEmail email: String, fullname: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        await uploadUserData(withEmail: email, fullname: fullname)
    }
    
    @MainActor
    func loadUserData() async {
        self.userSession = Auth.auth().currentUser
        guard let uid = userSession?.uid else { return }
        let user = await UserService.fetchUser(withUid: uid)
        self.currentUser = user
    }
   
    @MainActor
    func uploadUserData(withEmail email: String, fullname: String) async {
        do {
            guard let uid = userSession?.uid else { return }
            
            let user = User(id: uid, email: email, fullname: fullname)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            self.currentUser = user
            
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).setData(encodedUser)
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
}
