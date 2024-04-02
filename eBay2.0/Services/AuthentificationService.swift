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

    static let shared = AuthentificationService()
    
    private init() {
    }
    
    @MainActor
    func loginUser(withEmail email: String, password: String) async throws ->  AuthDataResult {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result
    }
    
    @MainActor
    func createUser(withEmail email: String, fullname: String, password: String) async throws -> User? {
        try await Auth.auth().createUser(withEmail: email, password: password)
        let user = await uploadUserData(withEmail: email, fullname: fullname)
        return user
    }
    
   
    @MainActor
    func uploadUserData(withEmail email: String, fullname: String) async -> User? {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return nil}
            
            let user = User(id: uid, email: email, fullname: fullname)
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return nil}
            
            try await FirebaseReferenceCollection(collectionReferance: .users).document(uid).setData(encodedUser)
            return user
        } catch {
            print("ERROR: ", error.localizedDescription)
            return nil
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("ERROR: ", error.localizedDescription)
        }
    }
    
}
