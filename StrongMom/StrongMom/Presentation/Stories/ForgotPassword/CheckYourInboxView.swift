//
//  CheckYourInboxView.swift
//  StrongMom
//
//  Created by artem on 29.01.2024.
//

import SwiftUI
import Combine

struct CheckYourInboxView: View {
    
    @ObservedObject var forgotPasswordViewModel: ForgotPasswordViewModel
    @State private var alertMessage = ""
    @State private var subscriberForCheckYourInboxView: AnyCancellable?
    @StateObject private var checkYourInboxViewModel = CheckYourInboxViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        
                        // MARK: - Mail icon Section
                        HStack(alignment: .center, content: {
                            Image(.mailIcon)
                        })
                        .padding(.top, 133)
                        
                        // MARK: - Header Section
                        HeaderView(title: Strings.checkYourInbox, multilineTextAlignment: .leading)
                            .padding(.top, 40)
                            .padding(.horizontal, 30)
                        
                        // MARK: - Subtitle Section
                        SubtitleView(subtitle: Strings.confirmationLinkInstructions, multilineTextAlignment: .center, font: AppFont.Body3)
                            .padding(.top, 22)
                            .padding(.horizontal, 25)
                        
                        // MARK: - Link Button Section
                        CustomLinkButtonWithText(text: Strings.didntReceiveLink, linkText: Strings.resendEmail, textColor: .customLightBlack) {
                            forgotPasswordViewModel.action.send(.forgotPassword)
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 59)
                        
                        // MARK: - TextField Section
                        VStack {
                            PrimaryTextField(text: $checkYourInboxViewModel.urlTextFieldText, placeholder: Strings.typeYourUrl)
                                .padding(.top, 20)
                                .padding(.horizontal, 20)
                            
                            HStack {
                                if checkYourInboxViewModel.isValidInput() {
                                    Text(Strings.correctUrl)
                                        .font(AppFont.Caption1)
                                        .foregroundColor(.customGreen)
                                } else {
                                    Text(Strings.urlRules)
                                        .font(AppFont.Caption1)
                                        .foregroundColor(.customLightBlack)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 32)
                            .animation(.easeInOut(duration: 0.3), value: checkYourInboxViewModel.valueForAnimation)
                        }
                        
                        // MARK: - Next Button Section
                        PrimaryButton(isValid: checkYourInboxViewModel.isValidInput(), text: Strings.next) {
                            checkYourInboxViewModel.showCreateNewPasswordView.toggle()
                            checkYourInboxViewModel.extractResetPasswordTokenFromURL(checkYourInboxViewModel.urlTextFieldText)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        .disabled(!checkYourInboxViewModel.isValidInput())
                        .fullScreenCover(isPresented: $checkYourInboxViewModel.showCreateNewPasswordView) {
                            CreateNewPasswordView(createNewPasswordViewModel: .init(resetPasswordToken: checkYourInboxViewModel.resetPasswordToken))
                        }
                        .alert(isPresented: $checkYourInboxViewModel.showAlert) {
                            Alert(title: Text(Strings.error),
                                  message: Text(checkYourInboxViewModel.alertMessage),
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
    CheckYourInboxView(forgotPasswordViewModel: .init())
}
