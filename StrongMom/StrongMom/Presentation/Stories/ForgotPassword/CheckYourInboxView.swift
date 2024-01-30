//
//  CheckYourInboxView.swift
//  StrongMom
//
//  Created by artem on 29.01.2024.
//

import SwiftUI
import Combine

struct CheckYourInboxView: View {
    
    @StateObject private var forgotPasswordViewModel = ForgotPasswordViewModel()
    @State private var alertMessage = ""
    @State private var subscriberForCheckYourInboxView: AnyCancellable?
    
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
                            setupSubscriberCheckYourInboxView()
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 59)
                        Spacer()
                    }
                    .navigationBarItems(leading: BackButton())
                })
            }
        }
    }
    
    // MARK: - Helper Methods
    private func setupSubscriberCheckYourInboxView() {
        subscriberForCheckYourInboxView = forgotPasswordViewModel.output
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
    CheckYourInboxView()
}
