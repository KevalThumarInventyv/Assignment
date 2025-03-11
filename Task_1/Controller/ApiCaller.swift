//
//  ApiCaller.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation

enum ApiError: Error {
    case requestFailed(Error)
    case invalidCredentials
}

class ApiCaller {
    static var shared = ApiCaller()

    var url: String =
        "Your API URL Add here"

    func getUserData(
        email: String, password: String,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        let user = LoginRequest(
            userName: email,
            password: password,
            softwareType: "AN",
            releaseVersion: "049"
        )
        
        guard let apiURL = URL(string: url) else {
            return
        }

        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(user)
        } catch {
            completion(.failure(ApiError.requestFailed(error)))
            return
        }

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.requestFailed(error)))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(UserModel.self, from: data)

                if result.isValidUser == false {
                    DispatchQueue.main.async {
                        completion(.failure(ApiError.invalidCredentials))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
