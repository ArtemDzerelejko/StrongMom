//
//  CreateNewPasswordViewModel.swift
//  StrongMom
//
//  Created by artem on 06.02.2024.
//

import SwiftUI
import Combine

final class CreateNewPasswordViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var passwordTextFieldText: String = ""
    @Published var confirmPassword: String = ""
    @Published var showErrorText = false
    @Published var valueForAnimation = 0
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        
    }
    
    // MARK: - Check valid input
    func isValidInput() -> Bool {
        let isPasswordValid = ValidatePassword.validatePassword(self.passwordTextFieldText)
        let isConfirmPasswordValid = !self.confirmPassword.isEmpty && self.confirmPassword == self.passwordTextFieldText
        return isPasswordValid && isConfirmPasswordValid
    }
    
    // MARK: - Public methods
    func isPasswordSecure() -> Bool {
        return ValidatePassword.validatePassword(passwordTextFieldText)
    }
}
