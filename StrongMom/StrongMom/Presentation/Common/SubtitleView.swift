//
//  SibtitleView.swift
//  StrongMom
//
//  Created by artem on 25.01.2024.
//

import SwiftUI

struct SubtitleView: View {
    let subtitle: String
    let multilineTextAlignment: TextAlignment
    let font: Font
    let textColor: Color
    
    init(subtitle: String, multilineTextAlignment: TextAlignment, font: Font, textColor: Color = .customLightBlack) {
        self.subtitle = subtitle
        self.multilineTextAlignment = multilineTextAlignment
        self.font = font
        self.textColor = textColor
    }
    
    var body: some View {
        Text(subtitle)
            .font(font)
            .foregroundColor(textColor)
            .lineLimit(2)
            .multilineTextAlignment(multilineTextAlignment)
    }
}
