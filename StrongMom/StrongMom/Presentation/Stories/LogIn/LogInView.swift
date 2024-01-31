//
//  LogInView.swift
//  StrongMom
//
//  Created by artem on 25.01.2024.
//

import SwiftUI
import Combine

struct LogInView: View {
    
    @StateObject private var logInViewModel = LogInViewModel()
    @State private var alertMessage = ""
    @State private var subscriberForLogInView: AnyCancellable?
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        // MARK: - Header Section
                        HStack {
                            HeaderView(title: Strings.welcomeBack, multilineTextAlignment: .leading)
                                .padding(.horizontal, 22)
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        // MARK: - Subtitle Section
                        HStack {
                            SubtitleView(subtitle: Strings.enterYourDataToAccessYourAccount, multilineTextAlignment: .leading, font: AppFont.Body2, textColor: .customDullDarkPurple)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                        .padding(.top, 24)
                        
                        // MARK: - TextField Section
                        VStack(alignment: .leading, spacing: 16) {
                            PrimaryTextField(text: $logInViewModel.emailTextFieldText, placeholder: Strings.email)
                            
                            SecureTextField(text: $logInViewModel.passwordTextFieldText, placeholder: Strings.password)
                        }
                        .padding(.top, 54)
                        .padding(.horizontal, 20)
                        
                        // MARK: - Forgot password Section
                        HStack(alignment: .center) {
                            Button {
                                logInViewModel.showForgotPasswordScreen = true
                            } label: {
                                Text(Strings.forgotPassword)
                                    .foregroundColor(.customLightBlue)
                                    .font(AppFont.Body1)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 126)
                        .fullScreenCover(isPresented: $logInViewModel.showForgotPasswordScreen) {
                            ForgotPasswordView()
                        }
                        
                        // MARK: - Continue Button Section
                        
                        PrimaryButton(isValid: logInViewModel.isValidLogIn(), text: Strings.continueButton) {
                            logInViewModel.action.send(.logInUser)
                            setupSubscriberForLogInView()
                        }
                        .padding(.top, 36)
                        .padding(.horizontal, 20)
                        .disabled(!logInViewModel.isValidLogIn())
                        .alert(isPresented: $logInViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text(Strings.ok)))
                        }
                        
                        // MARK: - Continue With Section
                        Text(Strings.continueWith)
                            .lineLimit(1)
                            .font(AppFont.Body2)
                            .foregroundColor(.customLightBlack)
                            .padding(.top, 26)
                            .padding(.horizontal, 129)
                        
                        // MARK: - Social Media Buttons Section
                        HStack(alignment: .center, spacing: 20) {
                            SocialMediaButton(buttonImage: AssetNames.facebook) {}
                            SocialMediaButton(buttonImage: AssetNames.google) {}
                            SocialMediaButton(buttonImage: AssetNames.apple) {}
                        }
                        .padding(.top, 22)
                        .padding(.horizontal, 98)
                        
                        // MARK: - Link Button Section
                        CustomLinkButtonWithText(text: Strings.dontHaveAnAccount, linkText: Strings.signUp, textColor: .customLightBlack) {
                            logInViewModel.showSignUpScreen.toggle()
                        }
                        .fullScreenCover(isPresented: $logInViewModel.showSignUpScreen) {
                            SignUpView()
                        }
                        .padding(.top, 26)
                        .padding(.horizontal, 71)
                        
                        Spacer()
                    }
                    .navigationBarItems(leading: BackButton())
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func setupSubscriberForLogInView() {
        subscriberForLogInView = logInViewModel.output
            .sink { [self] output in
                switch output {
                case let .showErrorAlert(error):
                    logInViewModel.showAlert = true
                    alertMessage = "\(error)"
                }
            }
    }
}

#Preview {
    LogInView()
}
