//
//  OnboardingIView.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    // MARK: - Public properties
    @State var showScreen: Bool = false
    @State var showLogIn: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                // MARK: - Setup background image
                Image(AssetNames.onboardingBackground)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    // MARK: - Welcome Text
                    Text(Strings.welcomeText)
                        .font(AppFont.Headline1)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 82)
                        .padding(.bottom, 133)
                    
                    // MARK: - Create Account Button
                    PrimaryButton(isValid: true, text: Strings.createAccount, action:   showScreen.toggle())
                    
                    
                        .fullScreenCover(isPresented: $showScreen) {
                            SignUpView()
                        }
                        .padding(35)
                    
                    // MARK: - Custom Link Button
                    CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn, textColor: .white) {
                        showLogIn.toggle()
                    }
                    .fullScreenCover(isPresented: $showLogIn) {
                        LogInView()
                    }
                    .padding(.leading, 69)
                    .padding(.trailing, 69)
                }
            }
        }
    }
}

#Preview {
    OnboardingScreenView()
}
