//
//  AuthorizationService.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Alamofire

class AuthorizationService: BaseService {
    
    func getAnonymousToken(completion: @escaping (Result<TokenResponseRemote, Error>) -> Void) {
        let headers: HTTPHeaders = ["Accept-Language": "en"]
        
        request(url: APIEndpoint.getToken.url,
                method: .get,
                parameters: EmptyParameters(),
                encoder: URLEncodedFormParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
}
