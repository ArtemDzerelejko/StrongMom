//
//  UserService.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Alamofire
import Foundation

class UserService: BaseService {
    
    func createUser(model: ModelForCreateUser, token: String, completion: @escaping (Result<UserTokenResponse, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept-Language": "en",
            "Content-Type": "application/json"
        ]
        
        request(url: APIEndpoint.createUser.url,
                method: .post,
                parameters: model,
                encoder: JSONParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
}
