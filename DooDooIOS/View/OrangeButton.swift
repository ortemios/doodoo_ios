//
//  OrangeButton.swift
//  DooDooIOS
//
//  Created by Валерия Бызова on 23.03.2022.
//

import SwiftUI

struct OrangeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.766, green: 0.344, blue: 0.27))
            .foregroundColor(.white)
            .clipShape(Capsule())
    
    }
}
