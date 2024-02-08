//
//  APIEndpoint.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://api-stag.k8s.strongmomapp.com/api/v1.0"
    
    case resetPassword(email: String)
    case changePassword(confirmationToken: String)
    case getToken
    case createUser
    case logInUser
    
    var path: String {
        switch self {
        case .resetPassword(let email):
            return "/password/reset/\(email)"
        case .getToken:
            return "/token"
        case .createUser:
            return "/application-users"
        case .logInUser:
            return "/login/email"
        case .changePassword(confirmationToken: let confirmationToken):
            return "/password/change/\(confirmationToken)"
        }
    }
    
    var url: URL {
        return URL(string: APIEndpoint.baseURL + path)!
    }
}
