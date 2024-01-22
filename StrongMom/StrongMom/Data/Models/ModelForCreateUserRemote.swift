//
//  ModelForCreateUserRemote.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

struct ModelForCreateUserRemote: Codable {
    var email: String
    var password: String
    var passwordConfirmation: String
    var timeZone: String
    var acceptedPrivacyPolicy: Bool
    var acceptedTermsAndConditions: Bool
}
