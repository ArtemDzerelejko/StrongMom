//
//  ModelForTokenRemote.swift
//  StrongMom
//
//  Created by artem on 02.02.2024.
//

import Foundation

// MARK: - TokenResponseRemote
struct TokenResponseRemote: Codable {
    let token: String?
    let refreshToken: String?
}

// MARK: - UserTokenResponseRemote
struct UserTokenResponseRemote: Codable {
    let userToken: String?
    let userRefreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "token"
        case userRefreshToken = "refreshToken"
    }
}

// MARK: - LogInUserTokenResponseRemote
struct LogInUserTokenResponseRemote: Codable {
    let logInUserToken: String?
    let logInUserRefreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case logInUserToken = "token"
        case logInUserRefreshToken = "refreshToken"
    }
}
