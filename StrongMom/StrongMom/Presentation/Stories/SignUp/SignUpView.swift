//
// SignUpView.swift
// StrongMom
//
// Created by artem on 18.01.2024.
//
import SwiftUI

struct SignUpView: View {

    @StateObject private var signUpViewModel = SignUpViewModel()
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLightGray.edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            HStack {
                                HeaderView(title: Strings.createAnAccount)
                                    .padding(.horizontal, 22)
                                Spacer()
                            }
                            .padding(.top, 15)
                            
                            VStack(alignment: .leading, spacing: 15, content: {
                                PrimaryTextField(text: $signUpViewModel.emailTextFieldText, placeholder: Strings.email)
                                
                                SecureTextField(text: $signUpViewModel.passwordTextFieldText, placeholder: Strings.password)
                            })
                            .padding(.top, 60)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                            
                            VStack() {
                                Text(Strings.passwordRules)
                                    .font(AppFont.Caption1)
                                    .foregroundColor(Color.customLightBlack)
                                    .padding(.bottom, 16)
                            }
                            .padding(.trailing, 39)
                            .padding(.leading, 30)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(spacing: 8, content: {
                                SecureTextField(text: $signUpViewModel.confirmPassword, placeholder: Strings.confirmPassword)
                                    .padding(.horizontal, 20)
                                
                                Text(Strings.passwordMismatch)
                                    .font(AppFont.Caption1)
                                    .foregroundColor(.customDeepPink)
                                    .onAppear {signUpViewModel.showErrorText = true}
                                    .padding(.trailing, 39)
                                    .padding(.leading, 30)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .opacity(signUpViewModel.passwordTextFieldText != signUpViewModel.confirmPassword ? 1 : 0)
                                    .animation(.easeInOut(duration: 0.3))
                            })
                            .padding(.bottom, 54)
                            
                            PrimaryButton(isValid: isValidInput(), text: Strings.continueWithEmail) {
                                signUpViewModel.createUser()
                                    .sink(receiveCompletion: { completion in
                                        switch completion {
                                        case .finished:
                                            break
                                        case .failure(let error):
                                            signUpViewModel.showAlert = true
                                            alertMessage = Strings.failedToCreateUser + "\(error.localizedDescription)"
                                        }
                                    }, receiveValue: { userTokenResponse in
                                        print("Successfully created user: \(userTokenResponse)")
                                    })
                                    .store(in: &signUpViewModel.cancellables)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 26)
                            .disabled(!isValidInput())
                            .alert(isPresented: $signUpViewModel.showAlert) {
                                Alert(title: Text(Strings.error),
                                      message: Text(alertMessage),
                                      dismissButton: .default(Text(Strings.ok)))
                            }
                            
                            Text(Strings.continueWith)
                                .lineLimit(1)
                                .font(AppFont.Body2)
                                .foregroundColor(.customLightBlack)
                                .padding(.horizontal, 129)
                            
                            HStack(alignment: .center, spacing: 20, content: {
                                SocialMediaButton(buttonImage: AssetNames.facebook) {}
                                SocialMediaButton(buttonImage: AssetNames.google) {}
                                SocialMediaButton(buttonImage: AssetNames.apple) {}
                            })
                            .padding(.top, 22)
                            .padding(.bottom, 26)
                            
                            HStack(alignment: .center, spacing: 6, content: {
                                Button(action: {
                                    self.signUpViewModel.checkboxIsActive.toggle()
                                }, label: {
                                    if signUpViewModel.checkboxIsActive {
                                        Image(AssetNames.checkBoxOn)
                                    } else {
                                        Image(AssetNames.checkBoxOff)
                                    }
                                })
                                AgreementButtonsView()
                            })
                            .padding(.bottom, 24)
                            
                            CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn, textColor: .customLightBlack, onTapAction: {})
                            
                            Spacer()
                        }
                        .onAppear {
                            signUpViewModel.fetchToken(completion: {result in
                                switch result {
                                case .success(let token):
                                    print("Successfully created user: \(token)")
                                case .failure(let error):
                                    signUpViewModel.showAlert = true
                                    alertMessage = Strings.failetToGetToken + "\(error.localizedDescription)"
                                }
                            })
                        }
                    }
                    .navigationBarItems(leading: BackButton())
            }
        }
    }
    
    private func isValidInput() -> Bool {
        let isEmailValid = !signUpViewModel.emailTextFieldText.isEmpty
        let isPasswordValid = !signUpViewModel.passwordTextFieldText.isEmpty
        let isConfirmPasswordValid = !signUpViewModel.confirmPassword.isEmpty && signUpViewModel.confirmPassword == signUpViewModel.passwordTextFieldText
        let isCheckboxActive = signUpViewModel.checkboxIsActive
        return isEmailValid && isPasswordValid && isConfirmPasswordValid && isCheckboxActive
    }
}
#Preview {
    SignUpView()
}
