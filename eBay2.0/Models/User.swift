//
//  User.swift
//  eBay2.0
//
//  Created by Dan Hozan on 21.03.2024.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    var fullname: String
    var profileImageLink: String?
}

extension User {
    
    static let MOCK_DATA = User(id: "1", email: "daniel@gmail.com", fullname: "Daniel Day-Lewis", profileImageLink: "Daniel Day-Lewis")
    static let MOCK_DATA_NIL_PROFILE = User(id: "1", email: "daniel@gmail.com", fullname: "Daniel Day-Lewis", profileImageLink: nil)
    
}
