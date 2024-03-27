//
//  FirabseRefCollection.swift
//  eBay2.0
//
//  Created by Dan Hozan on 22.03.2024.
//

import Foundation

import Foundation
import FirebaseFirestore

enum FirebaseCollection: String {
    case users
    case products
}


func FirebaseReferenceCollection(collectionReferance: FirebaseCollection) -> CollectionReference {
    return Firestore.firestore().collection(collectionReferance.rawValue)
}
