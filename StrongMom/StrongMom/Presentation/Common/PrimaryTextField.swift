//
//  PrimaryTextField.swift
//  StrongMom
//
//  Created by artem on 18.01.2024.
//

import SwiftUI

struct PrimaryTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(text: $text) {
            Text(placeholder)
                .foregroundColor(.placeholder)
                .font(AppFont.Caption1)
        }
        .autocapitalization(.none)
        .padding()
        .frame(height: 42)
        .keyboardType(.emailAddress)
        .overlay(RoundedRectangle(cornerRadius: 21)
            .stroke(
                Color.border, lineWidth: 1
            )
        )
        .font(AppFont.Caption1)
    }
}
