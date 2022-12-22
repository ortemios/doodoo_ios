//
//  DooDooIOSApp.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 18.03.2022.
//

import SwiftUI

@main
struct DooDooIOSApp: App {
    
    @StateObject var authViewModel = AuthViewModel.shared
    @StateObject var errorViewModel = ErrorViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.initializtionFinised {
                NavigationView {
                    if authViewModel.isLoggedIn {
                        UserScreen()
                    } else {
                        PhoneScreen()
                    }
                }
                .environmentObject(authViewModel)
                .alert(isPresented: $errorViewModel.isErrowShowing) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text(errorViewModel.message)
                    )
                }
            }
        }
    }
}
