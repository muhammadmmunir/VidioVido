//
//  ApiService.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

enum ApiServiceError: Error {
    case error(statusCode: Int, data: Data?)
    case someError
    case urlGeneration
    case nilResponse
}

protocol ApiServiceCancellable {
    func cancel()
}

extension URLSessionDataTask: ApiServiceCancellable {}

protocol ApiServiceInterface {
    typealias ApiServiceCompletion = (Result<Data, ApiServiceError>) -> Void
    
    func request(
        endpoint: Requestable,
        completion: @escaping ApiServiceCompletion
    ) -> ApiServiceCancellable?
}

final class ApiService: ApiServiceInterface {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private func request(
        _ urlRequest: URLRequest,
        completion: @escaping ApiServiceCompletion
    ) -> ApiServiceCancellable {

        let task = self.urlSession
            .dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    let error: ApiServiceError
                    if let response = response as? HTTPURLResponse {
                        error = .error(statusCode: response.statusCode, data: data)
                    } else {
                        error = .someError
                    }
                    completion(.failure(error))
                } else {
                    if let data = data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.nilResponse))
                    }
                    
                }
            }
        task.resume()
        return task
    }
    
    func request(
        endpoint: Requestable,
        completion: @escaping ApiServiceCompletion
    ) -> ApiServiceCancellable? {
        do {
            let urlRequest = try endpoint.urlRequest()
            return self.request(urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}
