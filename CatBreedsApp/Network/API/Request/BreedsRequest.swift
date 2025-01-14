//
//  CatBreedsRequest.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

// MARK: - CatBreedsRequest

enum CatBreedsRequest {
    case fetchCatBreeds(_ page: Int)
}

// MARK: - RequestProtocol

extension CatBreedsRequest: RequestProtocol {
    var path: String {
        "/v1/breeds"
    }

    var itemsCount: Int {
        10
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .fetchCatBreeds(page):
            return [
                URLQueryItem(name: "limit", value: String(itemsCount)),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }

    var requestType: RequestType {
        .GET
    }
}
