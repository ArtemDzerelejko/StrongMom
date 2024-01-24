//
//  AuthorizationRepositoryProtocol.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Foundation

protocol AuthorizationRepositoryProtocol {
    func getAnonymousToken(completion: @escaping (Result<TokenResponse, Error>) -> Void)
}
