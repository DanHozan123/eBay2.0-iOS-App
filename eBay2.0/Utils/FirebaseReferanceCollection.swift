//
//  FirabseRefCollection.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation

import Foundation
import FirebaseFirestore

enum FirebaseReferanceCollection: String {
    case users
}


func FirebaseReferenceCollection(collectionReferance: FirebaseReferanceCollection) -> CollectionReference {
    return Firestore.firestore().collection(collectionReferance.rawValue)
}
