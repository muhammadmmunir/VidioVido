//
//  Endpoint.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

enum ParameterEncoding {
    case queryString
    case json
}

enum URLRequestError: Error {
    case invalidURL
    case jsonEncoding
    case queryEncodingMissingURL
}

protocol Requestable {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    
    func urlRequest() throws -> URLRequest
}

final class Endpoint: Requestable {
    let urlString: String
    let method: HTTPMethod
    let encoding: ParameterEncoding
    let headers: [String: String]
    let parameters: [String: Any]
    
    init(
        urlString: String,
        method: HTTPMethod,
        encoding: ParameterEncoding = .queryString,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:]
    ) {
        self.urlString = urlString
        self.method = method
        self.encoding = encoding
        self.headers = headers
        self.parameters = parameters
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: self.urlString) else {
            throw URLRequestError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpMethod = self.method.rawValue
        try self.encodeParams(&urlRequest, params: self.parameters, encoding: self.encoding)
        
        return urlRequest
    }
    
    private func encodeParams(
        _ urlRequest: inout URLRequest,
        params: [String: Any],
        encoding: ParameterEncoding
    ) throws {
        switch encoding {
        case .json:
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: params)
                urlRequest.httpBody = httpBody
            } catch {
                throw URLRequestError.jsonEncoding
            }
        case .queryString:
            guard let url = urlRequest.url else {
                throw URLRequestError.queryEncodingMissingURL
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !params.isEmpty {
                
                var queryItems = [URLQueryItem]()
                params.forEach {
                    queryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
                }
                urlComponents.queryItems = queryItems
                urlRequest.url = urlComponents.url
            }
        }
    }
}
