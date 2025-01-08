//
//  RequestProtocol.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var queryItems: [URLQueryItem] { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(APIConstants.apiKey, forHTTPHeaderField: "x-api-key")
        
        return urlRequest
    }
}
