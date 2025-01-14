//
//  RequestManager.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element
}

final class RequestManager {

    // MARK: - Properties

    private let apiManager: APIManagerProtocol
    
    // MARK: - Initialization
    
    init(
        apiManager: APIManagerProtocol
    ) {
        self.apiManager = apiManager
    }
}

// MARK: - RequestManagerProtocol

extension RequestManager: RequestManagerProtocol {
    func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element {
        let data = try await apiManager.perform(request)
        let jsonDecoder = JSONDecoder()
        let decoded: Element = try jsonDecoder.decode(Element.self, from: data)
        return decoded
    }
}
