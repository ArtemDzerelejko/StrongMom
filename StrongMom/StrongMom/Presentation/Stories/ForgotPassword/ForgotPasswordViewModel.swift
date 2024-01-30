//
//  ForgotPasswordViewModel.swift
//  StrongMom
//
//  Created by artem on 30.01.2024.
//

import SwiftUI
import Combine

class ForgotPasswordViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var emailTextFieldText: String = ""
    @Published var showCheckYourInboxScreen: Bool = false
    @Published var showAlert = false
    
    var cancellables: Set<AnyCancellable> = []
    
    enum Action {
        case forgotPassword
    }
    
    enum Output {
        case showErrorAlert(error: String)
    }
    
    var action = PassthroughSubject<Action, Never>()
    var output = PassthroughSubject<Output, Never>()
    
    //MARK: - Private properties
    private let userUseCase = UserUseCase()
    
    // MARK: - Init
    init() {
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .forgotPassword:
                    self.forgotPassword()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Check valid input
    func isValidEmail() -> Bool {
        let isEmailValid = emailTextFieldText.isValidEmail()
        return isEmailValid
    }
    
    // MARK: - ForgotPassword
    func forgotPassword() {
        var tokenResponse: TokenResponse?
        do {
            tokenResponse = try TokenManager.get(service: Keys.strongMom)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        guard let token = tokenResponse?.token else { return }
        print(token)
        
        self.userUseCase.resetPassword(email: emailTextFieldText, anonymousToken: token) { result in
            switch result {
            case .success:
                print("Ok")
            case .failure(let error):
                self.output.send(.showErrorAlert(error: error.localizedDescription))
            }
        }
    }
}
