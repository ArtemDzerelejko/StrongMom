//
//  SecureTextField.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import SwiftUI

struct SecureTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        SecureField(text: $text) {
            Text(placeholder)
                .foregroundColor(.placeholder)
                .font(AppFont.Caption1)
        }
        .autocapitalization(.none)
        .padding()
        .frame(height: 42, alignment: .center)
        .overlay(RoundedRectangle(cornerRadius: 21)
            .stroke(
                Color.border, lineWidth: 1
            )
        )
        .font(AppFont.Caption1)
    }
}
