//
//  UserUseCase.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

final class UserUseCase {
    
    private let userRepository: UserRepositoryProtocol = UserRepository()
    
    func getToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        userRepository.getToken(completion: completion)
    }
    
    func createUser(model: ModelForCreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        userRepository.createUser(model: model, token: token, completion: completion)
    }
}
