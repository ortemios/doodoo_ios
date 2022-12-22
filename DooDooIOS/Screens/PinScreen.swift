//
//  SmsCodeScreen.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 19.03.2022.
//

import SwiftUI

struct PinScreen: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Введите код из SMS")
                .font(.title2)
                .fontWeight(.semibold)
            PinTextField(text: $loginViewModel.pin, count: 4)
            
            if loginViewModel.isLoading {
                ProgressView()
            } else {
                if loginViewModel.pin.isValidSmsCode() {
                    Button("Войти") {
                        loginViewModel.login()
                    }.buttonStyle(OrangeButton())
                }
            }
        }
    }
}

struct SmsCodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        PinScreen().environmentObject(LoginViewModel())
    }
}

