//
//  LoginScreen.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 18.03.2022.
//

import SwiftUI

struct PhoneScreen: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            NavigationLink(destination: PinScreen().environmentObject(loginViewModel), isActive: $loginViewModel.isShowingPinScreen) { EmptyView() }
                
            Text("Войти или зарегистрироваться")
                .font(.title3)
                .fontWeight(.medium)
            
            TextField("Номер телефона", text: $loginViewModel.phone)
                .keyboardType(.phonePad)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            if loginViewModel.isLoading {
                ProgressView()
            } else {
                if loginViewModel.smsSendTimeout == 0 {
                    if loginViewModel.phone.isValidPhone() {
                        Button("Отправить код") {
                            loginViewModel.sendSms()
                        }.buttonStyle(OrangeButton())
                            .padding(.horizontal)
                    }
                } else {
                    Text("Повторно отправить код можно через \(loginViewModel.smsSendTimeout) секунд")
                        .onReceive(timer) { input in loginViewModel.timerTick() }
                }
            }
        }.padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhoneScreen()
    }
}
