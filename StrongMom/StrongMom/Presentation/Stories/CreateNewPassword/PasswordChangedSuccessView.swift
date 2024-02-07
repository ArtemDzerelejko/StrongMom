//
//  PasswordChangedSuccessView.swift
//  StrongMom
//
//  Created by artem on 06.02.2024.
//

import SwiftUI

struct PasswordChangedSuccessView: View {
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
                            Image(.changedSuccess)
                        })
                        .padding(.top, 152)
                        
                        // MARK: - Header Section
                        VStack {
                            HeaderView(title: Strings.passwordChangedSuccessMessage, multilineTextAlignment: .center)
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 30)
                        
                        PrimaryButton(isValid: true, text: Strings.okay) {
                            print("Okey button")
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 35)
                        
                      Spacer()
                    }
                })
            }
        }
    }
}

#Preview {
    PasswordChangedSuccessView()
}
