//
//  UserRepository.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

protocol UserRepositoryProtocol {
    func createUser(model: CreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void)
    func logInUser(model:  LogInUser, anonymousToken: String, completion: @escaping (Result<LogInUserTokenResponse, Error>) -> Void)
    func resetPassword(email: String, anonymousToken: String, completion: @escaping (Result<EmptyDecodable, Error>) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    
    private let userService = UserService()
    
    func createUser(model: CreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        let rometeModel = model.toRemote
        userService.createUser(model: rometeModel, token: token) { result in
            switch result {
            case .success(let remoteModel):
                let userTokenResponse = UserTokenResponse(from: remoteModel)
                completion(.success(userTokenResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logInUser(model: LogInUser, anonymousToken: String, completion: @escaping (Result<LogInUserTokenResponse, Error>) -> Void) {
        let remoteModel = model.remoteModel
        userService.logInUser(model: remoteModel, anonymousToken: anonymousToken) { result in
            switch result {
            case .success(let remoteModel):
                let logInUserTokenResponse = LogInUserTokenResponse(from: remoteModel)
                completion(.success(logInUserTokenResponse))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    func resetPassword(email: String, anonymousToken: String, completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        userService.resetPassword(email: email, anonymousToken: anonymousToken) { result in
            completion(result)
        }
    }
}
