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
