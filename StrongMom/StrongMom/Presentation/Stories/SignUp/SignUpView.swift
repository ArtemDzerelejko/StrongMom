//
// SignUpView.swift
// StrongMom
//
// Created by artem on 18.01.2024.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: - Private properties
    @StateObject private var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray.edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        
                        // MARK: - Header Section
                        HStack {
                            HeaderView(title: Strings.createAnAccount, multilineTextAlignment: .leading)
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
                            
                            PasswordMismatchView(showErrorText: $signUpViewModel.showErrorText,
                                                 password: $signUpViewModel.passwordTextFieldText,
                                                 confirmPassword: $signUpViewModel.confirmPassword,
                                                 valueForAnimation: $signUpViewModel.valueForAnimation)
                        })
                        .padding(.bottom, 54)
                        
                        // MARK: - Continue Button Section
                        PrimaryButton(isValid: signUpViewModel.isValidInput(), text: Strings.continueWithEmail, action: signUpViewModel.action.send(.createUser))
                        
                        .padding(.horizontal, 20)
                        .padding(.bottom, 26)
                        .disabled(!signUpViewModel.isValidInput())
                        .fullScreenCover(isPresented: $signUpViewModel.showAccountConfirmationScreen) {
                            AccountConfirmationView()
                        }
                        .alert(isPresented: $signUpViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(signUpViewModel.alertMessage),
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
                        CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn, textColor: .customLightBlack, onTapAction: {
                            signUpViewModel.showLogInScreen.toggle()
                        })
                        .fullScreenCover(isPresented: $signUpViewModel.showLogInScreen) {
                            LogInView()
                        }
                        Spacer()
                    }
                    
                    // MARK: - On Appear Section
                    .onAppear {
                        signUpViewModel.action.send(.fetchToken)
                    }
                }
                .navigationBarItems(leading: BackButton())
            }
            .onTapGesture { self.endEditing() }
        }
    }
}

#Preview {
    SignUpView()
}
