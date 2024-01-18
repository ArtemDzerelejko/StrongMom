//
//  Localizable+Extensions.swift
//  StrongMom
//
//  Created by artem on 18.01.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
