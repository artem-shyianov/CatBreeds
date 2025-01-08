//
//  DataParser.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

protocol DataParserProtocol {
    func parse<Element: Decodable>(data: Data) throws -> Element
}

struct DataParser {

    // MARK: - Properties

    private let jsonDecoder: JSONDecoder

    // MARK: - Initialization

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: - DataParserProtocol

extension DataParser: DataParserProtocol {
    func parse<Element: Decodable>(data: Data) throws -> Element {
        return try jsonDecoder.decode(Element.self, from: data)
    }
}
