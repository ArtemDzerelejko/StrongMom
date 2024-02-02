//
//  View+Extensions.swift
//  StrongMom
//
//  Created by artem on 01.02.2024.
//

import SwiftUI

extension View {
    func endEditing() {
#if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
    }
}
