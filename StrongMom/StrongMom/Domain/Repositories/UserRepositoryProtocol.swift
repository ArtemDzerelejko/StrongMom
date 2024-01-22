//
//  UserRepositoryProtocol.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

protocol UserRepositoryProtocol {
    func getToken(completion: @escaping (Result<TokenResponse, Error>) -> Void)
    func createUser(model: ModelForCreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void)
}
