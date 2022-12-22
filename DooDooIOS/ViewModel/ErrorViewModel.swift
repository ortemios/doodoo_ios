//
//  ErrorViewModel.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 21.03.2022.
//

import Foundation

class ErrorViewModel : ObservableObject {
    
    static let shared = ErrorViewModel()
    
    @Published var message : String = ""
    @Published var isErrowShowing : Bool = false
    
    func show(_ error: AppError) {
        debugPrint(error.message)
        message = error.message
        isErrowShowing = true
    }
}
