//
//  Errors.swift
//  Today
//
//  Created by Артем Лавров on 17.03.2022.
//

import Foundation

protocol AppError : Error {
    
    var message: String { get }
}

struct ErrorWrongCode : AppError {
    var message: String = "Неправильный код"
}

struct ErrorInvalidToken : AppError {
    var message: String = "Невалидный токен"
}

struct ErrorLoginAttempts : AppError {
    var message: String = "Превышено количество попыток входа, попробуйте повторно запросить код"
}

struct ErrorSmsCodeTimeout : AppError {
    
    let timeout: Int
    var message: String = "Попробуте запросить код позже"
}

struct ErrorInvalidURL : AppError {
    var message: String = "Невалидный адрес запроса"
}

struct ErrorRequestFailure : AppError {
    var message: String = "Ошибка при выполнении запроса, проверьте Интернет-соединение"
}

struct ErrorRequestCodingError : AppError {
    var message: String = "Ошибка при сериализации запроса"
}

struct ResponseDecodingError : AppError {
    var message: String = "Ошибка при десериализации ответа сервера"
}

struct UnhandledServerError : AppError {
    let data : String

    var message: String {
        get {
            return "Сервер вернул необработанную ошибку : \(data)\nБудет исправлено"
        }
    }
}


extension Error {
    func print(at: String) {
        debugPrint("Ошибка при \(at) : \(self)")
    }
}
