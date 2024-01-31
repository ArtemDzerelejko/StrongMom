//
//  ModelForToken.swift
//  StrongMom
//
//  Created by artem on 31.01.2024.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let token: String
    let refreshToken: String
}

// MARK: - UserTokenResponse
struct UserTokenResponse: Codable {
    let userToken: String
    let userRefreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userToken = "token"
        case userRefreshToken = "refreshToken"
    }
}

// MARK: - LogInUserResponse
struct LogInUserTokenResponse: Codable {
    let logInUserToken: String
    let logInUserRefreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case logInUserToken = "token"
        case logInUserRefreshToken = "refreshToken"
    }
}
