//
//  CheckYourInboxViewModel.swift
//  StrongMom
//
//  Created by artem on 08.02.2024.
//

import SwiftUI

final class CheckYourInboxViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var urlTextFieldText: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showCreateNewPasswordView: Bool = false
    @Published var valueForAnimation = 0
    @Published var resetPasswordToken: String = ""
    
    // MARK: - Check valid input
    func isValidInput() -> Bool {
        let isURLValid = !self.urlTextFieldText.isEmpty
        return isURLValid
    }
    
    // MARK: - Extract Reset Password Token from URL
    func extractResetPasswordTokenFromURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let path = url.path
            
            if let range = path.range(of: Keys.resetPassword) {
                self.resetPasswordToken = String(path[range.upperBound...])
            } else {
                print("Path doesn't contain '/reset-password/'")
            }
        } else {
            print("Invalid URL")
        }
    }
}
