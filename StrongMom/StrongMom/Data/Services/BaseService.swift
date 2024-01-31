//
//  BaseService.swift
//  StrongMom
//
//  Created by artem on 23.01.2024.
//

import Alamofire

class BaseService {
    
    struct EmptyParameters: Encodable {}
    
    // MARK: - For T: Decodable
    private func handleResponse<T: Decodable>(response: AFDataResponse<T>, completion: @escaping (Result<T, Error>) -> Void) {
        switch response.result {
        case .success(let result):
            completion(.success(result))
        case .failure(let afError):
            var statusCode: Int?
            
            if let responseStatusCode = response.response?.statusCode {
                statusCode = responseStatusCode
                
                switch afError {
                case .responseValidationFailed(let reason):
                    switch reason {
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                        statusCode = code
                    default:
                        break
                    }
                default:
                    break
                }
            }
            completion(.failure(afError))
            print("Status Code: \(statusCode ?? -1)")
        }
    }
    
    func request<U: Encodable, T: Decodable>(url: URLConvertible,
                                             method: HTTPMethod,
                                             parameters: U? = nil,
                                             encoder: ParameterEncoder,
                                             headers: HTTPHeaders? = nil,
                                             completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }
    
    func request<U: Encodable>(url: URLConvertible,
                               method: HTTPMethod,
                               parameters: U? = nil,
                               encoder: ParameterEncoder,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200...500)
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let afError):
                    var statusCode: Int?
                    
                    if let responseStatusCode = response.response?.statusCode {
                        statusCode = responseStatusCode
                        
                        switch afError {
                        case .responseValidationFailed(let reason):
                            switch reason {
                            case .unacceptableStatusCode(let code):
                                print("Response status code was unacceptable: \(code)")
                                statusCode = code
                            default:
                                break
                            }
                        default:
                            break
                        }
                    }
                    completion(.failure(afError))
                    print("Status Code: \(statusCode ?? -1)")
                }
            }
    }
}
