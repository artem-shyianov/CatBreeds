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
    case success(breads: CatBreeds)
    case failure(error: Error)
}

@MainActor
final class CatBreedsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var breeds: CatBreeds = []
    @Published var state: BreedsViewState = .success(breads: [])
    @Published var isLoading: Bool = false
    
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
                self.isLoading = true
                
                let breeds = try await breedsFetcher.fetchCatBreeds(page: page)
                self.breeds += breeds
                
                state = .success(breads: self.breeds)
                self.isLoading = false
                hasMoreCats = !breeds.isEmpty
            } catch {
                self.isLoading = false
                state = .failure(error: error)
            }
        }
    }

    func loadMore() {
        print("Load more")
        page += 1
        fetchCatBreeds()
    }
}
