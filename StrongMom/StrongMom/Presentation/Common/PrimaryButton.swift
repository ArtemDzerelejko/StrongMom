//
//  PrimaryButton.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct PrimaryButton: View {
    let buttonText: String
    let buttonSize: CGSize
    let action: () -> Void
    
    init(text: String, size: CGSize, action: @escaping () -> Void) {
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
                .foregroundColor(.white)
        })
        .frame(width: buttonSize.width, height: buttonSize.height)
        .frame(maxWidth: .infinity)
        .background(Color.customPurple)
        .cornerRadius(23)
        .buttonStyle(PlainButtonStyle())
    }
}
