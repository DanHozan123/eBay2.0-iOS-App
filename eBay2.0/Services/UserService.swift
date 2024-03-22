//
//  UserService.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation
import Firebase

class UserService {
    
    static func fetchUser(withUid id: String) async -> User? {
        do {
            let snapshot = try await FirebaseReferenceCollection(collectionReferance: .users).document(id).getDocument()
            return try snapshot.data(as: User.self)
        } catch {
            print("ERROR: ", error.localizedDescription)
            return nil
        }
    }
}
