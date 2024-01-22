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
                .foregroundColor(.gray)
                .font(AppFont.Caption1)
        }
        .padding()
        .frame(width: 335, height: 42, alignment: .center)
        .background(
            Color.white
                .overlay(RoundedRectangle(cornerRadius: 21)
                    .stroke(
                        Color.customLightBlack, lineWidth: 1
                    )
                )
        )
        .font(AppFont.Caption1)
    }
}
