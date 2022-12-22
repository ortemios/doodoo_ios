//
//  UserService.swift
//  Today
//
//  Created by Артем Лавров on 17.03.2022.
//

import Foundation

protocol UserService {
    func getUser(token: String, completion: @escaping (User?, AppError?) -> Void)
}

class NetworkUserService : UserService {
    
    func updateUser() {
        
    }
    
    func getUser(token: String, completion: @escaping (User?, AppError?) -> Void) {
        Service.network.requestDTO(
            endpoint: "/user",
            body: NoDTO(),
            token: token,
            httpMethod: "GET"
        ) { (resp: MessageResponseDTO?, error) in
            if let resp = resp {
                let user = User(id: UUID(), firstname: resp.message, lastname: "", phone: "")
                completion(user, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
