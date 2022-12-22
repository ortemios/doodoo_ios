//
//  CodeDTO.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 20.03.2022.
//

import Foundation

struct CodeRequestDTO : Codable {
    var code: String
    var phone: String
}

struct CodeResponseDTO : Codable {
    var token: String
    var registered: Bool
}
