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
    let onTapAction: () -> Void
    
    init(text: String, linkText: String, onTapAction: @escaping () -> Void) {
        self.text = text
        self.linkText = linkText
        self.onTapAction = onTapAction
    }
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.white)
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

