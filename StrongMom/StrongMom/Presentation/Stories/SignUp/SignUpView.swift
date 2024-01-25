//
// SignUpView.swift
// StrongMom
//
// Created by artem on 18.01.2024.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    // MARK: - Private properties
    @StateObject private var signUpViewModel = SignUpViewModel()
    @State private var alertMessage = ""
    @State private var subscriber: AnyCancellable?
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray.edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        // MARK: - Header Section
                        HStack {
                            HeaderView(title: Strings.createAnAccount)
                                .padding(.horizontal, 22)
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        // MARK: - TextField Section
                        VStack(alignment: .leading, spacing: 15, content: {
                            PrimaryTextField(text: $signUpViewModel.emailTextFieldText, placeholder: Strings.email)
                            
                            SecureTextField(text: $signUpViewModel.passwordTextFieldText, placeholder: Strings.password)
                        })
                        .padding(.top, 60)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        
                        // MARK: - Password Rules Section
                        VStack() {
                            Text(Strings.passwordRules)
                                .font(AppFont.Caption1)
                                .foregroundColor(Color.customLightBlack)
                                .padding(.bottom, 16)
                        }
                        .padding(.trailing, 39)
                        .padding(.leading, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // MARK: - Confirm Password Section
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
                        
                        // MARK: - Continue Button Section
                        PrimaryButton(isValid: signUpViewModel.isValidInput(), text: Strings.continueWithEmail) {
                            signUpViewModel.action.send(.createUser)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 26)
                        .disabled(!signUpViewModel.isValidInput())
                        .alert(isPresented: $signUpViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text(Strings.ok)))
                        }
                        
                        // MARK: - Continue With Section
                        Text(Strings.continueWith)
                            .lineLimit(1)
                            .font(AppFont.Body2)
                            .foregroundColor(.customLightBlack)
                            .padding(.horizontal, 129)
                        
                        // MARK: - Social Media Buttons Section
                        HStack(alignment: .center, spacing: 20, content: {
                            SocialMediaButton(buttonImage: AssetNames.facebook) {}
                            SocialMediaButton(buttonImage: AssetNames.google) {}
                            SocialMediaButton(buttonImage: AssetNames.apple) {}
                        })
                        .padding(.top, 22)
                        .padding(.bottom, 26)
                        
                        // MARK: - Checkbox and Agreement Section
                        HStack(alignment: .center, spacing: 6, content: {
                            Button(action: {
                                signUpViewModel.checkboxIsActive.toggle()
                            }, label: {
                                Image(signUpViewModel.checkboxIsActive ? AssetNames.checkBoxOn : AssetNames.checkBoxOff)
                            })
                            AgreementButtonsView()
                        })
                        .padding(.bottom, 24)
                        
                        // MARK: - Link Button Section
                        CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn, textColor: .customLightBlack, onTapAction: {})
                        
                        Spacer()
                    }
                    
                    // MARK: - On Appear Section
                    .onAppear {
                        signUpViewModel.action.send(.fetchToken)
                        setupSubscriber()
                    }
                    
                }
                .navigationBarItems(leading: BackButton())
            }
        }
    }
    
    // MARK: - Helper Methods
    private func setupSubscriber() {
        subscriber = signUpViewModel.output
            .sink { [self] output in
                switch output {
                case let .showErrorAlert(error):
                    signUpViewModel.showAlert = true
                    alertMessage = "\(error)"
                }
            }
    }
}

#Preview {
    SignUpView()
}
