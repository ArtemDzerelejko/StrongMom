//
//  APIEndpoint.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://api-stag.k8s.strongmomapp.com/api/v1.0"
    
    case getToken
    case createUser
    
    var path: String {
        switch self {
        case .getToken:
            return "/token"
        case .createUser:
            return "/application-users"
        }
    }
    
    var url: String {
        return APIEndpoint.baseURL + path
    }
}
