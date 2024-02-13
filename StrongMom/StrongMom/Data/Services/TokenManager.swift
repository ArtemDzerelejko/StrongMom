//
//  TokenManager.swift
//  StrongMom
//
//  Created by artem on 29.01.2024.
//

import Foundation

class TokenManager {
    
    enum KeychainError: Error, LocalizedError {
        case duplicateEntry
        case unknown(OSStatus)
        case errorSecSuccess
        
        var errorDescription: String? {
            switch self {
            case .duplicateEntry:
                "Duplicate Entry"
            case .unknown(let oSStatus):
                "Unknown \(oSStatus)"
            case .errorSecSuccess:
                "Error sec success"
            }
        }
    }
    
    static func save(
        service: String,
        tokenResponse: TokenResponse
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecValueData as String: tokenResponse.token?.data(using: .utf8) as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecDuplicateItem:
            throw KeychainError.duplicateEntry
        case errSecSuccess:
            throw KeychainError.errorSecSuccess
        default:
            throw KeychainError.unknown(status)
        }
    }
    
    static func get(service: String) throws -> TokenResponse {
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
                  let token = String(data: retrievedData, encoding: .utf8)
            else { throw KeychainError.unknown(status) }
            
            return TokenResponse(token: token, refreshToken: "")
        case errSecItemNotFound:
            throw KeychainError.unknown(status)
        default:
            throw KeychainError.unknown(status)
        }
    }
}
