//
//  AccountConfirmationView.swift
//  StrongMom
//
//  Created by artem on 30.01.2024.
//

import SwiftUI

struct AccountConfirmationView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Setup background
                Color.customLightGray
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: true, content: {
                    VStack {
                        // MARK: - Mail icon Section
                        HStack(alignment: .center, content: {
                            Image(.mailIcon)
                        })
                        .padding(.top, 152)
                        
                        HeaderView(title: Strings.checkYourInbox, multilineTextAlignment: .center)
                            .padding(.top, 40)
                            .padding(.horizontal, 30)
                        
                        SubtitleView(subtitle: Strings.accountConfirmationInstructions, multilineTextAlignment: .center, font: AppFont.Body3)
                            .padding(.top, 22)
                            .padding(.horizontal, 22)
                            .foregroundColor(.customLightBlack)
                        
                        SubtitleView(subtitle: Strings.accountConfirmationReminder, multilineTextAlignment: .center, font: AppFont.Caption1, textColor: .customDullDarkPurple)
                            .padding(.top, 40)
                            .padding(.horizontal, 25)
                        
                        PrimaryButton(isValid: true, text: Strings.continueButton) {
                            print("Continue")
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 35)
                    }
                })
                
            }
        }
    }
}

#Preview {
    AccountConfirmationView()
}
