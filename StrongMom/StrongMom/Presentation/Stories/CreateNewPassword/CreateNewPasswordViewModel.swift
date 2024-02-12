//
//  CreateNewPasswordViewModel.swift
//  StrongMom
//
//  Created by artem on 06.02.2024.
//

import Combine

final class CreateNewPasswordViewModel: ObservableObject {
    
    // MARK: - Public properties
    @Published var passwordTextFieldText: String = ""
    @Published var confirmPassword: String = ""
    @Published var showErrorText = false
    @Published var valueForAnimation = 0
    @Published var alertMessage = ""
    @Published var showAlert = false
    private var resetPasswordToken: String
    
    var cancellables: Set<AnyCancellable> = []
    
    enum Action {
        case changePassword
    }
    
    enum Output {
        case showErrorAlert(error: String)
    }
    
    var action = PassthroughSubject<Action, Never>()
    var output = PassthroughSubject<Output, Never>()
    
    //MARK: - Private properties
    private let userUseCase = UserUseCase()
    
    init(resetPasswordToken: String) {
        self.resetPasswordToken = resetPasswordToken
        setupSubscriberForCreateNewPasswordView()
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
    
    // MARK: - Change password
    func changePassword() {
       TokenFetcher.getToken { [weak self] result in
           guard let self else { return }
           guard let token = result else { return }
           
           self.userUseCase.changePassword(password: passwordTextFieldText, passwordConfirmation: confirmPassword, confirmationToken: resetPasswordToken, anonymousToken: token) { result in
               print("Result: \(result)")
               switch result {
               case .success:
                   print("Ok")
               case .failure(let error):
                   if let networkError = error as? NetworkError {
                       self.output.send(.showErrorAlert(error: networkError.displayableError))
                   } else {
                       self.output.send(.showErrorAlert(error: error.localizedDescription))
                   }
               }
           }
        }
    }
    
    private func setupSubscriberForCreateNewPasswordView() {
        action
            .sink { [weak self] action in
                guard let self else { return }
                switch action {
                case .changePassword:
                    self.changePassword()
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
                }
            }
            .store(in: &cancellables)
    }
}
