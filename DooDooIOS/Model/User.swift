//
//  User.swift
//  Today
//
//  Created by Артем Лавров on 17.03.2022.
//

import Foundation

struct User {
    let id: UUID
    let firstname, lastname: String
    let phone: String
}

extension User {
    var fullname: String {
        get {
            return firstname + " " + lastname
        }
    }
}
