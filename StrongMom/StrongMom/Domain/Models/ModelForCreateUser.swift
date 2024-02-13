//
//  ModelForCreateUser.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

// MARK: - CreateUser
class CreateUser {
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    var timezone: String?
    var acceptedPrivacyPolicy: Bool?
    var acceptedTermsAndConditions: Bool?
    
    init(email: String?,
         password: String?,
         passwordConfirmation: String?,
         timezone: String?,
         acceptedPrivacyPolicy: Bool?,
         acceptedTermsAndConditions: Bool?) {
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
        self.timezone = timezone
        self.acceptedPrivacyPolicy = acceptedPrivacyPolicy
        self.acceptedTermsAndConditions = acceptedTermsAndConditions
    }
    
    init(from remote: CreateUserRemote) {
        self.email = remote.email ?? ""
        self.password = remote.password ?? ""
        self.passwordConfirmation = remote.passwordConfirmation ?? ""
        self.timezone = remote.timezone ?? ""
        self.acceptedPrivacyPolicy = remote.acceptedPrivacyPolicy
        self.acceptedTermsAndConditions = remote.acceptedTermsAndConditions
    }
    
    var toRemote: CreateUserRemote {
        CreateUserRemote(email: email,
                         password: password,
                         passwordConfirmation: passwordConfirmation,
                         timezone: timezone,
                         acceptedPrivacyPolicy: acceptedPrivacyPolicy,
                         acceptedTermsAndConditions: acceptedTermsAndConditions)
    }
}

// MARK: - LogInUser
class LogInUser: Codable {
    var email: String?
    var password: String?
    
    init(email: String? = nil,
         password: String? = nil) {
        self.email = email
        self.password = password
    }
    
    init(from remote: LogInUserRemote) {
        self.email = remote.email ?? ""
        self.password = remote.password ?? ""
    }
    
    var remoteModel: LogInUserRemote {
        LogInUserRemote(email: email,
                        password: password)
    }
}

// MARK: - ChangePasswordUser
class ChangePasswordUser: Codable {
    var password: String?
    var passwordConfirmation: String?
    
    init(password: String? = nil,
         passwordConfirmation: String? = nil) {
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    init(from remote: ChangePasswordUserRemote) {
        self.password = remote.password ?? ""
        self.passwordConfirmation = remote.passwordConfirmation ?? ""
    }
    
    var remoteModel: ChangePasswordUserRemote {
        ChangePasswordUserRemote(password: password, passwordConfirmation: passwordConfirmation)
    }
}
