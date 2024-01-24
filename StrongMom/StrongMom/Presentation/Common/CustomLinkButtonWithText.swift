//
//  CustomLinkButtonWithText.swift
//  StrongMom
//
//  Created by artem on 17.01.2024.
//

import SwiftUI

struct CustomLinkButtonWithText: View {
    let text: String
    let linkText: String
    let textColor: Color
    let onTapAction: () -> Void
    
    init(text: String, linkText: String, textColor: Color, onTapAction: @escaping () -> Void) {
        self.text = text
        self.linkText = linkText
        self.textColor = textColor
        self.onTapAction = onTapAction
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Text(text)
                .foregroundColor(textColor)
            Button(action: {
                onTapAction()
            }) {
                Text(linkText)
                    .foregroundColor(.customLightBlue)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .font(AppFont.Body1)
    }
}

