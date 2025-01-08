//
//  APIManager.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

// MARK: - APIManagerProtocol

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
}

// MARK: - APIManager

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession : URLSessionProtocol {}

final class APIManager {

    // MARK: - Properties

    private let urlSession: URLSessionProtocol

    // MARK: - Initialization

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
}

// MARK: - APIManagerProtocol

extension APIManager: APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
