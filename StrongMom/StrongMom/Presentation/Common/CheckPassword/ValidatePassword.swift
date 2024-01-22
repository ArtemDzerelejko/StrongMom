//
//  ValidatePassword.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Foundation

struct ValidatePassword {
    static func validatePassword(_ password: String) -> Bool {
        let minimumLength = 8
        let uppercaseRegex = ".*[A-Z]+.*"
        let lowercaseRegex = ".*[a-z]+.*"
        
        return password.count >= minimumLength &&
        password.range(of: uppercaseRegex, options: .regularExpression) != nil &&
        password.range(of: lowercaseRegex, options: .regularExpression) != nil
    }
}
