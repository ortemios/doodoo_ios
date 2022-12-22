//
//  AuthViewModel.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 18.03.2022.
//

import Foundation

class AuthViewModel : ObservableObject {
    
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var initializtionFinised: Bool = false
    var token: String?
    
    static let shared = AuthViewModel()
    
    init() {
        if let token = UserDefaults.standard.string(forKey: "token") {
            login(withToken: token) { error in
                if let error = error {
                    ErrorViewModel.shared.show(error)
                }
                self.initializtionFinised = true
            }
        } else {
            self.initializtionFinised = true
        }
    }
    
    func login(withToken: String, completion: @escaping (AppError?) -> Void) {
        token = withToken
        UserDefaults.standard.set(token, forKey: "token")
        Service.user.getUser(token: withToken) { user, error in
            if let user = user {
                self.user = user
                self.isLoggedIn = true
            }
            completion(error)
        }
    }
    
    func login(withPhone: String, andCode: String, completion: @escaping (AppError?) -> Void) {
        Service.auth.authorize(phone: withPhone, withCode: andCode) { token, error in
            if let token = token {
                self.login(withToken: token, completion: completion)
            } else {
                completion(error)
            }
        }
    }

    func logout() {
        if let token = token {
            Service.auth.logout(token: token) { error in
                if let error = error {
                    ErrorViewModel.shared.show(error)
                }
            }
            self.isLoggedIn = false
            self.user = nil
            self.token = nil
            UserDefaults.standard.removeObject(forKey: "token")
        }
    }
}

