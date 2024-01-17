//
//  OnboardingIView.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    var body: some View {
        ZStack {
            Image(Strings.onboardingBackground)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(Strings.welcomeText)
                    .font(.custom(Fonts.montserrat_Bold, size: 28))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 82)
                    .padding(.bottom, 133)
                
                PrimaryButton(text: Strings.createAccount, size: CGSize(width: 305, height: 46))
                    .padding(35)
                
                CustomLinkButtonWithText(text: Strings.haveAccount, linkText: Strings.logIn) {
                    print("Button tapped!")
                }
                .padding(.leading, 69)
                .padding(.trailing, 69)
            }
        }
    }
}

#Preview {
    OnboardingScreenView()
}
