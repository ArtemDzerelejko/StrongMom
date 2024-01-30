//
//  ModelForCreateUser.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

// MARK: - ModelForCreateUser
struct ModelForCreateUser: Codable {
    var email: String
    var password: String
    var passwordConfirmation: String
    var timezone: String
    var acceptedPrivacyPolicy: Bool
    var acceptedTermsAndConditions: Bool
}

// MARK: - ModelForLogInUser
struct ModelForLogInUser: Codable {
    var email: String
    var password: String
}

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
struct LogInUserResponse: Codable {
    let logInUserToken: String
    let logInUserRefreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case logInUserToken = "token"
        case logInUserRefreshToken = "refreshToken"
    }
}
