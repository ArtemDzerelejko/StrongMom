//
//  ModelForCreateUserRemote.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

// MARK: - CreateUserRemote
struct CreateUserRemote: Codable {
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    var timezone: String?
    var acceptedPrivacyPolicy: Bool?
    var acceptedTermsAndConditions: Bool?
}

// MARK: - LogInUserRemote
struct LogInUserRemote: Codable {
    var email: String?
    var password: String?
}
