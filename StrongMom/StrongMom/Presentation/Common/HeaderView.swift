//
//  HeaderView.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let multilineTextAlignment: TextAlignment
    
    init(title: String, multilineTextAlignment: TextAlignment) {
        self.title = title
        self.multilineTextAlignment = multilineTextAlignment
    }
    
    var body: some View {
        Text(title)
            .font(AppFont.Headline1)
            .foregroundColor(.customLightBlack)
            .lineLimit(3)
            .multilineTextAlignment(multilineTextAlignment)
    }
}
