//
//  CreateNewPasswordView.swift
//  StrongMom
//
//  Created by artem on 06.02.2024.
//

import SwiftUI

struct CreateNewPasswordView: View {
    
    @ObservedObject var createNewPasswordViewModel: CreateNewPasswordViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        
                        // MARK: - Header Section
                        HStack {
                            HeaderView(title: Strings.createNewPassword, multilineTextAlignment: .leading)
                            Spacer()
                        }
                        .padding(.top, 15)
                        .padding(.horizontal, 20)
                        
                        // MARK: - Subtitle Section
                        HStack {
                            SubtitleView(subtitle: Strings.newPasswordInstructions, multilineTextAlignment: .leading, font: AppFont.Body2)
                            Spacer()
                        }
                        .padding(.top, 22)
                        .padding(.horizontal, 20)
                        
                        // MARK: - TextField Section
                        
                        VStack(spacing: 8, content: {
                            SecureTextField(text: $createNewPasswordViewModel.passwordTextFieldText, placeholder: Strings.newPassword)
                                .padding(.top, 24)
                                .padding(.horizontal, 20)
                            
                            HStack {
                                if createNewPasswordViewModel.isPasswordSecure() {
                                    Text(Strings.securePassword)
                                        .font(AppFont.Caption1)
                                        .foregroundColor(.customGreen)
                                } else {
                                    Text(Strings.passwordRules)
                                        .font(AppFont.Caption1)
                                        .foregroundColor(.customLightBlack)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 32)
                            .animation(.easeInOut(duration: 0.3), value: createNewPasswordViewModel.valueForAnimation)
                        })
                        
                        // MARK: - TextField Section
                        
                        VStack(spacing: 8, content: {
                            SecureTextField(text: $createNewPasswordViewModel.confirmPassword, placeholder: Strings.confirmNewPassword)
                                .padding(.top, 16)
                                .padding(.horizontal, 20)
                            
                            PasswordMismatchView(showErrorText: $createNewPasswordViewModel.showErrorText,
                                                 password: $createNewPasswordViewModel.passwordTextFieldText,
                                                 confirmPassword: $createNewPasswordViewModel.confirmPassword,
                                                 valueForAnimation: $createNewPasswordViewModel.valueForAnimation)
                        })
                        
                        // MARK: - Continue Button Section
                        
                        PrimaryButton(isValid: createNewPasswordViewModel.isValidInput(), text: Strings.next) {
                            createNewPasswordViewModel.action.send(.changePassword)
                        }
                        .padding(.top, 36)
                        .padding(.horizontal, 20)
                        .disabled(!createNewPasswordViewModel.isValidInput())
                        .alert(isPresented: $createNewPasswordViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(createNewPasswordViewModel.alertMessage),
                                  dismissButton: .default(Text(Strings.ok)))
                        }
                        
                        Spacer()
                    }
                    .navigationBarItems(leading: BackButton())
                })
            }
        }
    }
}

#Preview {
    CreateNewPasswordView(createNewPasswordViewModel: .init(resetPasswordToken: ""))
}
