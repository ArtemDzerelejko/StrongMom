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
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        SecureField(text: $text) {
            Text(placeholder)
                .foregroundColor(.placeholder)
                .font(AppFont.Caption1)
        }
        .focused($isFocused)
        .autocapitalization(.none)
        .padding()
        .keyboardType(.emailAddress)
        .frame(height: 42)
        .overlay(RoundedRectangle(cornerRadius: 21)
            .stroke(
                Color.border, lineWidth: 1
            )
        )
        .onTapGesture {
            isFocused = true
        }
        .font(AppFont.Caption1)
    }
}
