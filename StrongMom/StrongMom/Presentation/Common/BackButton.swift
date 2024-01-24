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
            Image(AssetNames.backArrow)
        })
        .foregroundColor(.customLightBlack)
    }
}
