//
//  SplashView.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: - Private properties
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            OnboardingScreenView()
        } else {
            ZStack {
                
                // MARK: - Setup background
                Color.customPurple.ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    // MARK: - Main Logo Image
                    Image(AssetNames.mainLogo)
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
