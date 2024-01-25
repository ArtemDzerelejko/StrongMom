//
//  SignUpViewModel.swift
//  StrongMom
//
//  Created by artem on 22.01.2024.
//

import SwiftUI
import Combine
import RegexBuilder

final class SignUpViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var tokenResponse: TokenResponse?
    @Published var userTokenResponse: UserTokenResponse?
    
    @Published var emailTextFieldText: String = ""
    @Published var passwordTextFieldText: String = ""
    @Published var confirmPassword: String = ""
    @Published var checkboxIsActive = false
    @Published var isPasswordValid = false
    @Published var isPasswordMatchValid = false
    @Published var acceptedPrivacyPolicy = true
    @Published var acceptedTermsAndConditions = true
    @Published var buttonInValid = false
    @Published var showAlert = false
    @Published var showErrorText = false
    
    static let word = OneOrMore(.word)
    
    var cancellables: Set<AnyCancellable> = []
    
    enum Action {
        case fetchToken
        case createUser
    }
    
    enum Output {
        case showErrorAlert(error: String)
    }
    
    var action = PassthroughSubject<Action, Never>()
    var output = PassthroughSubject<Output, Never>()
    
    // MARK: - Private properties
    private let authorizationUseCase = AuthorizationUseCase()
    private let userUseCase = UserUseCase()
    private let emailPattern = Regex {
        Capture {
            ZeroOrMore {
                word
                "."
            }
            word
        }
        "@"
        Capture {
            word
            OneOrMore {
                "."
                word
            }
        }
    }
    
    // MARK: - Init
    init() {
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .createUser:
                    self.createUser()
                case .fetchToken:
                    self.fetchToken()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Check valid email
    private func isValidEmail() -> Bool {
        guard let match = emailTextFieldText.firstMatch(of: emailPattern) else { return false }
        let (wholeMatch, name, domain) = match.output
        guard wholeMatch == emailTextFieldText else { return false }
        if name.count < 3 || domain.count < 3 { return false }
        return true
    }
    
    // MARK: - Check valid input
    func isValidInput() -> Bool {
        let isEmailValid = self.isValidEmail()
        let isPasswordValid = ValidatePassword.validatePassword(self.passwordTextFieldText)
        let isConfirmPasswordValid = !self.confirmPassword.isEmpty && self.confirmPassword == self.passwordTextFieldText
        let isCheckboxActive = self.checkboxIsActive
        return isEmailValid && isPasswordValid && isConfirmPasswordValid && isCheckboxActive
    }
    
    // MARK: - Fetch Token
    func fetchToken() -> AnyPublisher<TokenResponse, Error> {
        return Future<TokenResponse, Error> { promise in
            self.authorizationUseCase.getAnonymousToken { result in
                switch result {
                case .success(let tokenResponse):
                    self.tokenResponse = tokenResponse
                    print("Token response: \(tokenResponse)")
                    promise(.success(tokenResponse))
                case .failure(let error):
                    print("Failed to get token response: \(error.localizedDescription)")
                    self.output.send(.showErrorAlert(error: error.localizedDescription))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Create User
    func createUser() -> AnyPublisher<UserTokenResponse, Error> {
        return Future<UserTokenResponse, Error> { promise in
            guard let token = self.tokenResponse?.token else {
                print("Token not available. Make sure to fetch the token first.")
                self.output.send(.showErrorAlert(error: "\(Error.self)"))
                return
            }
            
            let modelForCreateUser = ModelForCreateUser(
                email: self.emailTextFieldText,
                password: self.passwordTextFieldText,
                passwordConfirmation: self.confirmPassword,
                timezone: TimeZone.current.identifier,
                acceptedPrivacyPolicy: self.acceptedPrivacyPolicy,
                acceptedTermsAndConditions: self.acceptedTermsAndConditions
            )
            
            print(modelForCreateUser)
            
            self.userUseCase.createUser(model: modelForCreateUser, token: token) { result in
                switch result {
                case .success(let userTokenResponse):
                    self.userTokenResponse = userTokenResponse
                    print("UserTokenResponse: \(userTokenResponse)")
                    promise(.success(userTokenResponse))
                case .failure(let error):
                    print("Failed to fetch token: \(error.localizedDescription)")
                    self.output.send(.showErrorAlert(error: error.localizedDescription))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
