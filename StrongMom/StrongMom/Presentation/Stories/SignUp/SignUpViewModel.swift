//
//  SignUpViewModel.swift
//  StrongMom
//
//  Created by artem on 22.01.2024.
//

import UIKit

class SignUpViewModel: ObservableObject {
    @Published var tokenResponse: TokenResponse?
    @Published var userTokenResponse: UserTokenResponse?
    private let userUseCase = UserUseCase()
    
    func fetchToken() {
        userUseCase.getToken { result in
            switch result {
            case .success(let tokenResponse):
                self.tokenResponse = tokenResponse
            case .failure(let error):
                print("Failed to fetch token: \(error)")
            }
        }
    }
    
    func createUser(model: ModelForCreateUser) {
        
        guard let token = tokenResponse?.token else {
            print("Token not available. Make sure to fetch the token first.")
            return
        }
        print(token)
        
        userUseCase.createUser(model: model, token: token) { result in
            switch result {
            case .success(let userResponse):
                self.userTokenResponse = userResponse
                print("UserTokenResponse: \(userResponse)")
            case .failure(let error):
                print("Failed to fetch token: \(error.localizedDescription)")
            }
        }
    }
}
