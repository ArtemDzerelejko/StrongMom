//
//  ModelForCreateUser.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

struct ModelForCreateUser: Codable {
    var email: String
    var password: String
    var passwordConfirmation: String
    var timezone: String
    var acceptedPrivacyPolicy: Bool
    var acceptedTermsAndConditions: Bool
}

struct TokenResponse: Codable {
    let token: String
    let refreshToken: String
}

struct UserTokenResponse: Codable {
    let userToken: String
    let userRefreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userToken = "token"
        case userRefreshToken = "refreshToken"
    }
}
