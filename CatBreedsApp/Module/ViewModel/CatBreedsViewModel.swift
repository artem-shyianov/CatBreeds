//
//  CatBreedsViewModel.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

// MARK: - CatsFetcher

protocol CatBreedsFetcher {
    func fetchCatBreeds(page: Int) async throws -> CatBreeds
}

enum BreedsViewState {
    case loading
    case success(breads: CatBreeds)
    case failure(error: Error)
}

@MainActor
final class CatBreedsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var breeds: CatBreeds = []
    @Published var state: BreedsViewState = .success(breads: [])
    
    private let breedsFetcher: CatBreedsFetcher
    private(set) var page = 0
    private(set) var hasMoreCats = true
    

    // MARK: - Initialization

    init(
        breedsFetcher: CatBreedsFetcher
    ) {
        self.breedsFetcher = breedsFetcher
    }
}

// MARK: - Internal Helper Methods

extension CatBreedsViewModel {
    func fetchCatBreeds() {
        Task {
            do {
                if self.breeds.isEmpty {
                    state = .loading
                }
                
                let breeds = try await breedsFetcher.fetchCatBreeds(page: page)
                self.breeds += breeds
                
                state = .success(breads: self.breeds)
                hasMoreCats = !breeds.isEmpty
            } catch {
                state = .failure(error: error)
            }
        }
    }

    func fetchMoreBreedsIfNeeded(with breed: CatBreed) {
        guard hasReachedEnd(of: breed) && hasMoreCats else {
            return
        }
           
        page += 1
        fetchCatBreeds()
    }
    
    func hasReachedEnd(of bread: CatBreed) -> Bool {
        breeds.last?.id == bread.id
    }
}
