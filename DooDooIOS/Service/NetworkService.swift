//
//  NetworkService.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 20.03.2022.
//

import Foundation

class NoDTO : Codable { }

class NetworkService {
    let serverUrl: String
    
    init(serverUrl: String) {
        self.serverUrl = serverUrl
    }
    
    func requestData<T: Encodable>(endpoint: String, body: T, token: String? = nil, httpMethod: String, completion: @escaping (Data?, AppError?) -> Void) {
        
        guard let url = URL(string: serverUrl + endpoint) else {
            completion(nil, ErrorInvalidURL())
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        if let token = token {
            urlRequest.setValue(token, forHTTPHeaderField: "authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !(body is NoDTO) {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                info(endpoint: endpoint, message: "Ошибка при сериализации запроса", data: error)
                completion(nil, ErrorRequestCodingError())
                return
            }
        }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.info(endpoint: endpoint, message: "Метод вернул ошибку при передаче данных", data: error)
                    completion(nil, ErrorRequestFailure())
                } else {
                    if let response = response as? HTTPURLResponse,
                       let data = data {
                        self.info(endpoint: endpoint, message: "Сервер вернул текст", data: String(decoding: data, as: UTF8.self))
                        do {
                            if (200..<300).contains(response.statusCode) {
                                completion(data, nil)
                            } else {
                                let message = try JSONDecoder().decode(MessageResponseDTO.self, from: data)
                                self.info(endpoint: endpoint, message: "Сервер вернул сообщение об ошибке", data: message)
                                completion(nil, UnhandledServerError(data: message.message))
                            }
                        } catch let error {
                            self.info(endpoint: endpoint, message: "Ошибка при десериализации ответа", data: error)
                            completion(nil, ResponseDecodingError())
                        }
                    } else {
                        self.info(endpoint: endpoint, message: "Метод ничего не вернул совсем")
                        completion(nil, nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    private func info(endpoint: String, message: String, data: Any? = nil) {
        var suffix = ""
        if let data = data {
            suffix = " '\(data)'"
        }
        debugPrint("\(serverUrl + endpoint): \(message)" + suffix)
    }
    
    func requestDTO<T: Encodable, V: Decodable>(endpoint: String, body: T, token: String? = nil, httpMethod: String, completion: @escaping (V?, AppError?) -> Void) {
        self.requestData(endpoint: endpoint, body: body, token: token, httpMethod: httpMethod) { (data, error) in
            if let data = data {
                do {
                    let dto = try JSONDecoder().decode(V.self, from: data)
                    self.info(endpoint: endpoint, message: "Метод отработал хорошо", data: data)
                    completion(dto, nil)
                } catch {
                    self.info(endpoint: endpoint, message: "Ошибка при десериализации ответа", data: error)
                    completion(nil, ResponseDecodingError())
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func request<T: Encodable>(endpoint: String, body: T, token: String? = nil, completion: @escaping (AppError?) -> Void, httpMethod: String) {
        self.requestData(endpoint: endpoint, body: body, token: token, httpMethod: httpMethod) { (data, error) in
            completion(error)
        }
    }
}
