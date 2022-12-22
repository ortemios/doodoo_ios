//
//  UserScreen.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 19.03.2022.
//

import SwiftUI

struct UserScreen: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button("Выйти, \(authViewModel.user?.fullname ?? "")") {
            authViewModel.logout()
        }.buttonStyle(OrangeButton())
        Text("AAAAA")
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserScreen().environmentObject(AuthViewModel())
    }
}
