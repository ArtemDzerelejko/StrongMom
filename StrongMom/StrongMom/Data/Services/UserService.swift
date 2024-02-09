//
//  UserService.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Alamofire
import Foundation

class UserService: BaseService {
    
//    private func commonHeaders(token: String) -> HTTPHeaders {
//        return [
//            "Authorization": "Bearer \(token)",
//            "Accept-Language": "en",
//            "Content-Type": "application/json"
//        ]
//    }
//    
//    private func headersForChangePassword(token: String) -> HTTPHeaders {
//        return [
//            "Authorization": "Bearer \(token)",
//            "Accept-Language": "en",
//        ]
//    }
    
    private func commonHeaders(token: String, includeContentType: Bool = true) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": "en"
        ]
        
        if includeContentType {
            headers["Content-Type"] = "application/json"
        }
        
        return headers
    }


    private func headersForChangePassword(token: String) -> HTTPHeaders {
        return commonHeaders(token: token, includeContentType: false)
    }
    
    func createUser(model: CreateUserRemote, token: String, completion: @escaping (Result<UserTokenResponseRemote, Error>) -> Void) {
        let headers = commonHeaders(token: token)
        
        request(url: APIEndpoint.createUser.url,
                method: .post,
                parameters: model,
                encoder: JSONParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
    
    func logInUser(model: LogInUserRemote, anonymousToken: String, completion: @escaping (Result<LogInUserTokenResponseRemote, Error>) -> Void) {
        let headers = commonHeaders(token: anonymousToken)
        
        request(url: APIEndpoint.logInUser.url,
                method: .post,
                parameters: model,
                encoder: JSONParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
    
    func resetPassword(email: String, anonymousToken: String, completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        let headers = commonHeaders(token: anonymousToken)
        
        request(url: APIEndpoint.resetPassword(email: email).url,
                method: .post,
                parameters: BaseService.EmptyParameters(),
                encoder: JSONParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
    
    
    func changePassword(password: String,
                        passwordConfirmation: String,
                        confirmationToken: String,
                        anonymousToken: String,
                        completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        let headers = headersForChangePassword(token: anonymousToken)
        
        let parameters: [String: String] = [
            "password": password,
            "passwordConfirmation": passwordConfirmation
        ]
        
        request(url: APIEndpoint.changePassword(confirmationToken: confirmationToken).url,
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
}
