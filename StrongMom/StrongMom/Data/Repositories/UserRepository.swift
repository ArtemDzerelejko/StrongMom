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
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
