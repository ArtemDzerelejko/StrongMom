//
//  BaseService.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Alamofire

class BaseService {
    struct EmptyParameters: Encodable {}
    
    func request<T: Decodable, U: Encodable>(url: URLConvertible,
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
}