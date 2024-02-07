//
//  PasswordMismatchView.swift
//  StrongMom
//
//  Created by artem on 06.02.2024.
//

import SwiftUI

struct PasswordMismatchView: View {
    @Binding var showErrorText: Bool
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var valueForAnimation: Int
    
    var body: some View {
        Text(Strings.passwordMismatch)
            .font(AppFont.Caption1)
            .foregroundColor(.customDeepPink)
            .onAppear { showErrorText = true }
            .padding(.trailing, 39)
            .padding(.leading, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(password != confirmPassword ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: valueForAnimation)
    }
}
