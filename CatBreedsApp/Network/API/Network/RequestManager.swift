//
//  RequestManager.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

protocol RequestManagerProtocol {
    func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element
}

final class RequestManager {

    // MARK: - Properties

    private let apiManager: APIManagerProtocol
    private let parser: DataParserProtocol
    
    // MARK: - Initialization
    
    init(
        apiManager: APIManagerProtocol,
        parser: DataParserProtocol
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }
}

// MARK: - RequestManagerProtocol

extension RequestManager: RequestManagerProtocol {
    func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element {
        let data = try await apiManager.perform(request)
        let decoded: Element = try parser.parse(data: data)
        return decoded
    }
}
