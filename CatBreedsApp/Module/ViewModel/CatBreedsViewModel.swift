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

    @Published var hasMoreCats = true
    @Published var breeds: CatBreeds = []
    @Published var isLoading: Bool = true
    @Published var state: BreedsViewState = .success(breads: [])
    
    private let breedsFetcher: CatBreedsFetcher
    private(set) var page = 0

    // MARK: - Initialization

    init(
        breedsFetcher: CatBreedsFetcher
    ) {
        self.breedsFetcher = breedsFetcher
    }
}

// MARK: - Internal Helper Methods

extension CatBreedsViewModel {
    func reset() {
        self.page = 0
        self.breeds = []
    }
    
    func fetchCatBreeds() async {
        isLoading = true
        do {
            let breeds = try await breedsFetcher.fetchCatBreeds(page: page)
            self.breeds += breeds
            
            state = .success(breads: self.breeds)
            hasMoreCats = !breeds.isEmpty
        } catch {
            state = .failure(error: error)
        }
        isLoading = false
        
    }

    func fetchMoreBreeds() async {
        page += 1
        await fetchCatBreeds()
    }
    
    func hasReachedEnd(of bread: CatBreed) -> Bool {
        breeds.last?.id == bread.id
    }
}
