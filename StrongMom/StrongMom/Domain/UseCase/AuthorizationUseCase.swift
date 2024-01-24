//
//  AuthorizationUseCase.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Foundation

final class AuthorizationUseCase {
    private let authorizationRepository: AuthorizationRepositoryProtocol = AuthorizationRepository()
    
    func getAnonymousToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        authorizationRepository.getAnonymousToken(completion: completion)
    }
}
