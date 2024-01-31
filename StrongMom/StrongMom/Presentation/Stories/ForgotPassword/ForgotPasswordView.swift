//
//  ForgotPasswordView.swift
//  StrongMom
//
//  Created by artem on 29.01.2024.
//

import SwiftUI
import Combine

struct ForgotPasswordView: View {
    
    @StateObject private var forgotPasswordViewModel = ForgotPasswordViewModel()
    @State private var alertMessage = ""
    @State private var subscriberForForgotPasswordView: AnyCancellable?
    
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
                            HeaderView(title: Strings.forgotPassword, multilineTextAlignment: .leading)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                        .padding(.top, 15)
                        
                        // MARK: - Subtitle Section
                        HStack {
                            SubtitleView(subtitle: Strings.resetPasswordInstructions, multilineTextAlignment: .leading, font: AppFont.Body2, textColor: .customDullDarkPurple)
                            
                            Spacer()
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                        
                        // MARK: - TextField Section
                        VStack {
                            PrimaryTextField(text: $forgotPasswordViewModel.emailTextFieldText, placeholder: Strings.typeYourEmail)
                        }
                        .padding(.top, 54)
                        .padding(.horizontal, 20)
                        
                        // MARK: - Next Button Section
                        PrimaryButton(isValid: forgotPasswordViewModel.isValidEmail(), text: Strings.next) {
                            forgotPasswordViewModel.action.send(.forgotPassword)
                            forgotPasswordViewModel.showCheckYourInboxScreen.toggle()
                            setupSubscriberForForgotPasswordView()
                        }
                        .padding(.top, 36)
                        .padding(.horizontal, 20)
                        .disabled(!forgotPasswordViewModel.isValidEmail())
                        .fullScreenCover(isPresented: $forgotPasswordViewModel.showCheckYourInboxScreen) {
                            CheckYourInboxView()
                        }
                        .alert(isPresented: $forgotPasswordViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text(Strings.ok)))
                        }
                        Spacer()
                    }
                    .navigationBarItems(leading: BackButton())
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func setupSubscriberForForgotPasswordView() {
        subscriberForForgotPasswordView = forgotPasswordViewModel.output
            .sink { [self] output in
                switch output {
                case let .showErrorAlert(error):
                    forgotPasswordViewModel.showAlert = true
                    alertMessage = "\(error)"
                }
            }
    }
}

#Preview {
    ForgotPasswordView()
}
