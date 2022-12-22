//
//  LoginViewModel.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 19.03.2022.
//

import Foundation

class LoginViewModel : ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var phone: String = ""
    @Published var pin: String = ""
    @Published var isShowingPinScreen: Bool = false
    @Published var smsSendTimeout: Int = 0
    
    func sendSms() {
        isLoading = true
        Service.auth.sendCode(phone: phone) { error in
            self.isLoading = false
            if let error = error {
                ErrorViewModel.shared.show(error)
                if let error = error as? ErrorSmsCodeTimeout {
                    self.smsSendTimeout = error.timeout
                }
            } else {
                self.isShowingPinScreen = true
            }
        }
    }
    
    func timerTick() {
        smsSendTimeout = max(0, smsSendTimeout - 1)
    }
    
    func login() {
        isLoading = true
        AuthViewModel.shared.login(withPhone: phone, andCode: pin) { error in
            self.isLoading = false
            if let error = error {
                ErrorViewModel.shared.show(error)
                if error is ErrorLoginAttempts {
                    self.isShowingPinScreen = false
                }
            }
        }
    }
}

extension String {
    func isValidPhone() -> Bool {
        if count < 10 { return false }
        if !(first!.isNumber || first == "+") { return false }
        for c in suffix(count - 1) {
            if !c.isNumber {
                return false
            }
        }
        return true
    }
    
    func isValidSmsCode() -> Bool {
        return count == 4 && allSatisfy { $0.isNumber }
    }
}
