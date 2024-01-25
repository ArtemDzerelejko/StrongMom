//
//  String+Extensions.swift
//  StrongMom
//
//  Created by artem on 25.01.2024.
//

import Foundation
import RegexBuilder

extension String {
    // MARK: - Check valid Email
    func isValidEmail() -> Bool {
        let word = OneOrMore(.word)
        let emailPattern = Regex {
            Capture {
                ZeroOrMore {
                    word
                    "."
                }
                word
            }
            "@"
            Capture {
                word
                OneOrMore {
                    "."
                    word
                }
            }
        }

        guard let match = firstMatch(of: emailPattern) else { return false }
        let (wholeMatch, _, _) = match.output
        return wholeMatch == self
    }
}
