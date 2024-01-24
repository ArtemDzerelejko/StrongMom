//
//  HeaderView.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(AppFont.Headline1)
            .foregroundColor(.customLightBlack)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
