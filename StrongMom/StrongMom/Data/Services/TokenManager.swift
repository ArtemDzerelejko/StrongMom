//
//  TokenManager.swift
//  StrongMom
//
//  Created by artem on 29.01.2024.
//

import Foundation

class TokenManager {
    
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func save(
        service: String,
        tokenResponse: TokenResponse
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecValueData as String: tokenResponse.token.data(using: .utf8) as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecDuplicateItem:
            throw KeychainError.duplicateEntry
        case errSecSuccess:
            print("Token saved successfully")
        default:
            throw KeychainError.unknown(status)
        }
    }
    
    static func get(service: String) throws -> TokenResponse? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue as AnyObject
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecSuccess:
            guard let retrievedData = item as? Data,
                  let token = String(data: retrievedData, encoding: .utf8) else {
                return nil
            }
            return TokenResponse(token: token, refreshToken: "")
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainError.unknown(status)
        }
    }
}
