//
//  TokenFetcher.swift
//  StrongMom
//
//  Created by artem on 12.02.2024.
//

import SwiftUI

class TokenFetcher {
      static func getToken(service: String) -> String? {
        var tokenResponse: TokenResponse?
        
        do {
          tokenResponse = try TokenManager.get(service: service)
        } catch {
          print("Error: \(error.localizedDescription)")
        }
        
        guard let token = tokenResponse?.token else { return nil }
        
        return token
      }
}
