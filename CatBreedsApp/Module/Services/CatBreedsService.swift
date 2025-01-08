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
    private let cache: Cache<Int, CatBreeds>
    
    // MARK: - Initialization

    init(requestManager: RequestManagerProtocol,
         cache: Cache<Int, CatBreeds>) {
        self.requestManager = requestManager
        self.cache = cache
    }
}

// MARK: - CatBreedsFetcher

extension CatBreedsService: CatBreedsFetcher {
    func fetchCatBreeds(page: Int) async throws -> CatBreeds {
        let requestData = CatBreedsRequest.fetchCatBreeds(page)
        do {
            if let cachedResult = cache.value(forKey: page) {
                return cachedResult
            } else {
                let result: CatBreeds = try await requestManager.perform(requestData)
                cache.insert(result, forKey: page)
                return result
            }
        } catch {
            throw error
        }
    }
}
