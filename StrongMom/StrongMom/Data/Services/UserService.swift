//
//  UserService.swift
//  StrongMom
//
//  Created by artem on 19.01.2024.
//

import Alamofire
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

class UserService {
    
    struct EmptyParameters: Encodable {}
    
    private func request<T: Decodable, U: Encodable>(url: URLConvertible,
                                                     method: HTTPMethod,
                                                     parameters: U? = nil,
                                                     encoder: ParameterEncoder,
                                                     headers: HTTPHeaders? = nil,
                                                     completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func getToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let headers: HTTPHeaders = ["Accept-Language": "en"]
        
        request(url: APIEndpoint.getToken.url,
                method: .get,
                parameters: EmptyParameters(),
                encoder: URLEncodedFormParameterEncoder.default,
                headers: headers,
                completion: completion)
    }
    
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
