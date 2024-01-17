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
    
    init(text: String, size: CGSize) {
        self.buttonText = text
        self.buttonSize = size
    }
    
    var body: some View {
        Button(action: {
            print("Button press")
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
