//
//  TokenFetcher.swift
//  StrongMom
//
//  Created by artem on 12.02.2024.
//

import SwiftUI

typealias token = String?

class TokenFetcher {
    static func getToken(completion: @escaping(token) -> Void) {
        
        let responceToken = try? TokenManager.get(service: Keys.strongMom)
        
        if let token = responceToken?.token {
            completion(token)
        } else {
            let authorizationUseCase = AuthorizationUseCase()
            authorizationUseCase.getAnonymousToken { result in
                if case .success(let tokenResponse) = result {
                    try? TokenManager.save(service: Keys.strongMom, tokenResponse: tokenResponse)
                    completion(tokenResponse.token)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
