//
//  API.swift
//  Today
//
//  Created by Артем Лавров on 17.03.2022.
//

import Foundation

protocol AuthService {
    
    func sendCode(phone: String, completion: @escaping (AppError?) -> Void)
    
    func authorize(phone: String, withCode: String, completion: @escaping (String?, AppError?) -> Void)
    
    func logout(token: String, completion: @escaping (AppError?) -> Void)
}

class NetworkAuthService : AuthService {
    func sendCode(phone: String, completion: @escaping (AppError?) -> Void) {
        Service.network.request(
            endpoint: "/auth/login",
            body: LoginRequestDTO(phone: phone),
            completion: completion,
            httpMethod: "POST"
        )
    }
    
    func authorize(phone: String, withCode: String, completion: @escaping (String?, AppError?) -> Void) {
        Service.network.requestDTO(
            endpoint: "/auth/code",
            body: CodeRequestDTO(code: withCode, phone: phone),
            httpMethod: "POST"
        ) { (resp: CodeResponseDTO?, error) in completion(resp?.token, error) }
    }
    
    func logout(token: String, completion: @escaping (AppError?) -> Void) {
        Service.network.request(
            endpoint: "/auth/logout",
            body: LogoutRequestDTO(all: false),
            token: token,
            completion: completion,
            httpMethod: "POST"
        )
    }
}
