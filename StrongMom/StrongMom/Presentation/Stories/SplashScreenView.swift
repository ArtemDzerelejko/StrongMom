//
//  SplashView.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            OnboardingScreenView()
        } else {
            ZStack {
                Color.customPurple.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(Strings.mainLogo)
                        .frame(width: 162.18, height: 205.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
