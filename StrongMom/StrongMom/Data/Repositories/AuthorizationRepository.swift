//
//  AuthorizationRepository.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Foundation

final class AuthorizationRepository: AuthorizationRepositoryProtocol {
    private let authorizationService = AuthorizationService()
    
    func getAnonymousToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        authorizationService.getAnonymousToken { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
