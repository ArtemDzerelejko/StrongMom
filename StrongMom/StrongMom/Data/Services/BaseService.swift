//
//  BaseService.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Alamofire
import Foundation

struct EmptyDecodable: Decodable {
    init(from decoder: Decoder) throws {}
    init() {}
}

class BaseService {
    
    struct EmptyParameters: Encodable {}
    
    // MARK: - For T: Decodable
    private func handleResponse<T: Decodable>(response: AFDataResponse<T>, completion: @escaping (Result<T, Error>) -> Void) {
        switch response.result {
        case .success(let result):
            completion(.success(result))
        case .failure(_):
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let networkError = try decoder.decode(NetworkError.self, from: data)
                    completion(.failure(networkError))
                } catch {
                    let JSONErorr: NetworkError = .init(errorDescription: Strings.canNotParsError, error: Strings.error, violations: nil)
                    completion(.failure(JSONErorr))
                }
            } else {
                let JSONErorr: NetworkError = .init(errorDescription: Strings.canNotFindData, error: Strings.error, violations: nil)
                completion(.failure(JSONErorr))
            }
        }
    }
    
    func request<U: Encodable, T: Decodable>(url: URLConvertible,
                                             method: HTTPMethod,
                                             parameters: U? = nil,
                                             encoder: ParameterEncoder,
                                             headers: HTTPHeaders? = nil,
                                             completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }
    
    func request<U: Encodable>(url: URLConvertible,
                               method: HTTPMethod,
                               parameters: U? = nil,
                               encoder: ParameterEncoder,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Result<EmptyDecodable, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200..<300)
            .debugLog()
            .responseDecodable(of: EmptyDecodable.self) { response in
                print(response.request)
                print(response.response)
                print(response.response?.statusCode)
                print("Responde data \(response.data)")
                if let code = response.response?.statusCode, (code >= 200 && code < 300) {
                    completion(.success(EmptyDecodable()))
                } else {
                    self.handleResponse(response: response, completion: completion)
                }
            }
    }
}

