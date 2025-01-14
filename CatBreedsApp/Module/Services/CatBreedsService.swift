//
//  CatBreedsService.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

// MARK: - CatBreedsService

struct CatBreedsService {

    // MARK: - Properties

    private let requestManager: RequestManagerProtocol
    
    // MARK: - Initialization

    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

// MARK: - CatBreedsFetcher

extension CatBreedsService: CatBreedsFetcher {
    func fetchCatBreeds(page: Int) async throws -> CatBreeds {
        let requestData = CatBreedsRequest.fetchCatBreeds(page)
        do {
            let result: CatBreeds = try await requestManager.perform(requestData)
            return result
        } catch {
            throw error
        }
    }
}
