//
//  LogInViewModel.swift
//  StrongMom
//
//  Created by artem on 25.01.2024.
//

import SwiftUI
import Combine

final class LogInViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var emailTextFieldText: String = ""
    @Published var passwordTextFieldText: String = ""
    @Published var logInUserResponse: LogInUserResponse?
    @Published var showAlert = false
    @Published var showForgotPasswordScreen: Bool = false
    
    var cancellables: Set<AnyCancellable> = []
    
    enum Action {
        case logInUser
    }
    
    enum Output {
        case showErrorAlert(error: String)
    }
    
    var action = PassthroughSubject<Action, Never>()
    var output = PassthroughSubject<Output, Never>()
    
    // MARK: - Private properties
    private let userUseCase = UserUseCase()
    
    // MARK: - Init
    init() {
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .logInUser:
                    self.logInUser()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Check valid input
    func isValidLogIn() -> Bool {
        let isEmailValidsd = emailTextFieldText.isValidEmail()
        let isValidPasswords = ValidatePassword.validatePassword(passwordTextFieldText)
        return isEmailValidsd && isValidPasswords
    }
    
    // MARK: LogIn User
    func logInUser() {
        var tokenResponse: TokenResponse?
        do {
            tokenResponse = try TokenManager.get(service: Keys.strongMom)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        let modelForLogInUser = ModelForLogInUser(email: self.emailTextFieldText, password: self.passwordTextFieldText)
        
        print(modelForLogInUser)
        
        guard let token = tokenResponse?.token else {return}
        self.userUseCase.logInUser(model: modelForLogInUser, anonymousToken: token) { result in
            switch result {
            case .success(let logInUserResponse):
                self.logInUserResponse = logInUserResponse
                print("LogInUserResponse: \(logInUserResponse)")
            case .failure(let error):
                print("Failed to fetch token: \(error.localizedDescription)")
                self.output.send(.showErrorAlert(error: error.localizedDescription))
            }
        }
    }
}