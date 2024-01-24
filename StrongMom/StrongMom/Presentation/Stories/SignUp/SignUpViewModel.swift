//
//  SignUpViewModel.swift
//  StrongMom
//
//  Created by artem on 22.01.2024.
//

import SwiftUI

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
    
    func fetchToken() {
        authorizationUseCase.getAnonymousToken { result in
            switch result {
            case .success(let tokenResponse):
                self.tokenResponse = tokenResponse
            case .failure(let error):
                print("Failed to fetch token: \(error)")
            }
        }
    }
    
    func createUser(model: ModelForCreateUser, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        guard let token = tokenResponse?.token else {
            print("Token not available. Make sure to fetch the token first.")
            return
        }
        print(token)
        
        userUseCase.createUser(model: model, token: token) { result in
            
            switch result {
            case .success(let userTokenResponse):
                self.userTokenResponse = userTokenResponse
                print("UserTokenResponse: \(userTokenResponse)")
                completion(.success(userTokenResponse))
            case .failure(let error):
                print("Failed to fetch token: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
