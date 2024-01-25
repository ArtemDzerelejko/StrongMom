//
//  PrimaryButton.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct PrimaryButton: View {
    let isValid: Bool
    let buttonText: String
    let action: () -> Void
    
    
    init(isValid: Bool?, text: String, action: @escaping () -> Void) {
        self.isValid = isValid ?? true
        self.buttonText = text
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(buttonText)
                .font(AppFont.Body1)
                .foregroundColor(isValid ? Color.white : Color.customGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: 46)
                .background(isValid ? Color.customPurple : Color.customDarkGray)
                .cornerRadius(23)
        })
        .disabled(!isValid)
        .buttonStyle(PlainButtonStyle())
    }
}
