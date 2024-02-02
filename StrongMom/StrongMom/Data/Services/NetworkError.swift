//
//  NetworkError.swift
//  StrongMom
//
//  Created by artem on 01.02.2024.
//

import Foundation

public struct NetworkError: Codable, Error {
  let errorDescription: String?
  let error: String?
  let violations: Violation?
   
  struct Violation: Codable {
    let detail:String?
    let title:String?
    let type:String?
    let violations:[ViolationDetails]?
     
    struct ViolationDetails: Codable {
      let propertyPath:String?
      let title:String?
      let type:String?
    }
     
    public var formatedError: String {
      var message = ""
      if let violations = violations {
        for violation in violations {
          guard let append = violation.title?.replacingOccurrences(of: "This value", with: "The \(violation.propertyPath ?? "")") else { continue }
          if message.count > 0 { message = "\(message)\n\(append)" }
          else         { message = "\(append)"       }
        }
      } else {
        message = detail ?? title ?? ""
      }
      return message
    }
  }
}

// MARK: - Displayable error string
public extension NetworkError {
    var displayableError: String {
        return self.violations?.formatedError ??
            self.errorDescription ??
            self.error ??
            "Fallback error message"
    }
}

