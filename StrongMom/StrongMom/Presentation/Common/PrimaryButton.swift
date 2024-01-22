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
    let buttonSize: CGSize
    let action: () -> Void
    
    
    init(isValid: Bool?, text: String, size: CGSize, action: @escaping () -> Void) {
        self.isValid = isValid ?? true
        self.buttonText = text
        self.buttonSize = size
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
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(isValid ? Color.customPurple : Color.customDarkGray)
                .cornerRadius(23)
        })
        .disabled(!isValid)
        .buttonStyle(PlainButtonStyle())
    }
}
