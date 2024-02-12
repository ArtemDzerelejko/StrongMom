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
    @Published var alertMessage = ""
    
    var cancellables: Set<AnyCancellable> = []
    
    enum Action {
        case forgotPassword
    }
    
    enum Output {
        case showCheckYourInboxScreen
        case showErrorAlert(error: String)
    }
    
    var action = PassthroughSubject<Action, Never>()
    var output = PassthroughSubject<Output, Never>()
    
    //MARK: - Private properties
    private let userUseCase = UserUseCase()
    
    // MARK: - Init
    init() {
        setupSubscriberForForgotPasswordView()
    }
    
    // MARK: - Check valid input
    func isValidEmail() -> Bool {
        let isEmailValid = emailTextFieldText.isValidEmail()
        return isEmailValid
    }
    
    // MARK: - ForgotPassword
    func forgotPassword() {
        guard let token = TokenFetcher.getToken(service: Keys.strongMom) else { return }
        
        self.userUseCase.resetPassword(email: emailTextFieldText, anonymousToken: token) { result in
            print(result)
            switch result {
            case .success:
                self.output.send(.showCheckYourInboxScreen)
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
                if let networkError = error as? NetworkError {
                    self.output.send(.showErrorAlert(error: networkError.displayableError))
                } else {
                    self.output.send(.showErrorAlert(error: error.localizedDescription))
                }
            }
        }
    }
    
    private func setupSubscriberForForgotPasswordView() {
        action
            .sink { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .forgotPassword:
                    self.forgotPassword()
                }
            }
            .store(in: &cancellables)
        output
            .sink { [weak self] output in
                guard let self else { return }
                switch output {
                case let .showErrorAlert(error):
                    alertMessage = "\(error)"
                    self.showAlert = true
                case .showCheckYourInboxScreen:
                    self.showCheckYourInboxScreen.toggle()
                }
            }
            .store(in: &cancellables)
    }
}
