//
//  BackButton.swift
//  StrongMom
//
//  Created by artem on 18.01.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(Strings.backArrow)
        })
        .foregroundColor(.customLightBlack)
//        .padding(.trailing, 327)
//        .padding(.leading, 20)
//        .frame(maxWidth: .infinity,alignment: .leading)
//        .frame(alignment: .topLeading)
    }
}
