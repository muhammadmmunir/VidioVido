//
//  HomeService.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

enum HomeServiceError: Error {
    case error(ApiServiceError)
    case parsing
}

protocol HomeServiceInterface {
    var mockResponse: Data? { get set }
    
    @discardableResult
    func fetch(
        completion: @escaping (Result<[Content], HomeServiceError>) -> Void
    ) -> ApiServiceCancellable?
}

final class HomeService: HomeServiceInterface {
    private let endpoint = Endpoint(
        urlString: "https://vidio.com/api/contents",
        method: .get,
        encoding: .queryString,
        headers: [:],
        parameters: [:])
    private let apiService: ApiServiceInterface
    private let jsonDecoder: JSONDecoder
    var mockResponse: Data?
    
    init(
        apiService: ApiServiceInterface = ApiService(),
        jsonDecoder: JSONDecoder = .init(),
        mockResponse: Data? = nil
    ) {
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
        self.mockResponse = mockResponse
    }
    
    func fetch(
        completion: @escaping (Result<[Content], HomeServiceError>) -> Void
    ) -> ApiServiceCancellable? {
        return self.apiService.request(endpoint: self.endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let json = JSONDecoder()
                    
                    // MARK: - MOCKING RESPONSE
                    let dataModified: Data
                    if let mockResponse = self.mockResponse {
                        dataModified = mockResponse
                    } else {
                        dataModified = data
                    }
                    
                    let content = try json.decode([ContentDTO].self, from: dataModified)
                    let entity = content.toEntity()
                    
                    DispatchQueue.main.async {
                        completion(.success(entity))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.parsing))
                    }
                }
            case .failure(let apiServiceError):
                DispatchQueue.main.async {
                    completion(.failure(.error(apiServiceError)))
                }
            }
        }
    }
}
