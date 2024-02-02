//
//  UserUseCase.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

final class UserUseCase {
    private let userRepository: UserRepositoryProtocol = UserRepository()
    
    func createUser(model: ModelForCreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        userRepository.createUser(model: model, token: token, completion: completion)
    }
    
    func logInUser(model: ModelForLogInUser, anonymousToken: String, completion: @escaping (Result<LogInUserTokenResponse, Error>) -> Void) {
        userRepository.logInUser(model: model, anonymousToken: anonymousToken, completion: completion)
    }
    
    func resetPassword(email: String, anonymousToken: String, completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        userRepository.resetPassword(email: email, anonymousToken: anonymousToken, completion: completion)
    }
}
