//
//  CatBreedsFetcherMock.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

struct MockCatBreedsFetcher: CatBreedsFetcher {
    var fetchCatBreedsResult = CatBreed.mock
    func fetchCatBreeds(page: Int) async -> CatBreeds {
        return fetchCatBreedsResult
    }
}
