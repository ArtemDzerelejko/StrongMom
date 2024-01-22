//
//  AppFont.swift
//  StrongMom
//
//  Created by artem on 18.01.2024.
//

import SwiftUI

struct AppFont {
    /// Monserrat.bold, size: 28
    static let Headline1 = Font.custom(Montserraat.bold.weight, size: 28)
    /// Monserrat.semiBold, size: 14
    static let Body1 = Font.custom(Montserraat.semiBold.weight, size: 14)
    /// Monserrat.regular, size: 14
    static let Body2 = Font.custom(Montserraat.regular.weight, size: 14)
    /// Monserrat.regular, size: 12
    static let Caption1 = Font.custom(Montserraat.regular.weight, size: 12)
    
    static var custom: (Montserraat, CGFloat) -> Font = { (weight, size) in
        return Font.custom(weight.weight, size: size)
    }
}

enum Montserraat: String {
    case extraBold = "Montserrat-ExtraBold"
    case extraLight = "Montserrat-ExtraLight"
    case bold = "Montserrat-Bold"
    case light = "Montserrat-Light"
    case medium = "Montserrat-Medium"
    case regular = "Montserrat-Regular"
    case semiBold = "Montserrat_SemiBold"
    case thin = "Montserrat-Thin"
    
    var weight: String {return self.rawValue}
}
