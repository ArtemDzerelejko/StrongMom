//
//  UserRepository.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let userService = UserService()
    
    func createUser(model: ModelForCreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        userService.createUser(model: model, token: token) { result in
            completion(result)
        }
    }
    
    func logInUser(model: ModelForLogInUser, anonymousToken: String, completion: @escaping (Result<LogInUserTokenResponse, Error>) -> Void) {
        userService.logInUser(model: model, anonymousToken: anonymousToken) { result in
            completion(result)
        }
    }
    
    func resetPassword(email: String, anonymousToken: String, completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        userService.resetPassword(email: email, anonymousToken: anonymousToken) { result in
            completion(result)
        }
    }
}
