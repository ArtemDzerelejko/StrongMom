//
//  SignUpViewModel.swift
//  StrongMom
//
//  Created by artem on 22.01.2024.
//

import SwiftUI
import Combine

final class SignUpViewModel: ObservableObject {
    @Published var tokenResponse: TokenResponse?
    private let authorizationUseCase = AuthorizationUseCase()
    
    @Published var userTokenResponse: UserTokenResponse?
    private let userUseCase = UserUseCase()
    
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
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        authorizationUseCase.getAnonymousToken { result in
            switch result {
            case .success(let tokenResponse):
                self.tokenResponse = tokenResponse
                completion(.success(tokenResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUser() -> AnyPublisher<UserTokenResponse, Error> {
            return Future<UserTokenResponse, Error> { promise in
                guard let token = self.tokenResponse?.token else {
                    print("Token not available. Make sure to fetch the token first.")
                    promise(.failure(Error.self as! Error))
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
                        promise(.failure(error))
                    }
                }
            }
            .eraseToAnyPublisher()
        }
}
