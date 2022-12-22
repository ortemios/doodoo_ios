//
//  Service.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 20.03.2022.
//

import Foundation

class Service {
    static let network: NetworkService = NetworkService(serverUrl: "http://localhost:9533/api/v1")
    static let auth: AuthService = NetworkAuthService()
    static let user: UserService = NetworkUserService()
//    static let auth: AuthService = DummyAuthService()
//    static let user: UserService = DummyUserService()

    static func perform(_ task: @escaping () async -> Void, completion: @escaping () -> Void = {}) {
        Task {
            await task()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func delayed(_ seconds: Int, completion: @escaping () -> Void = {}) {
        perform({ try? await Task.sleep(nanoseconds: UInt64(1_000_000_000 * seconds)) }, completion: completion)
    }
}
