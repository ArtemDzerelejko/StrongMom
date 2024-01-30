//
//  SocialMediaButton.swift
//  StrongMom
//
//  Created by artem on 18.01.2024.
//

import SwiftUI

struct SocialMediaButton: View {
    let buttonImage: String
    let action: () -> Void
    
    init(buttonImage: String, action: @escaping () -> Void) {
        self.buttonImage = buttonImage
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(buttonImage)
            
        })
        .buttonStyle(PlainButtonStyle())
    }
}
