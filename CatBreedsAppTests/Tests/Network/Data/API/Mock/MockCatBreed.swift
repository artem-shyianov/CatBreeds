//
//  CatBreedMock.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

// MARK: - Mock data

extension CatBreed {
    static let mock = loadMockCatBreeds()
}

private func loadMockCatBreeds() -> CatBreeds {
    guard
        let url = Bundle.main.url(forResource: "CatBreedsMock", withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
        return []
    }

    let decoder = JSONDecoder()
    let jsonMock = try? decoder.decode(CatBreeds.self, from: data)
    return jsonMock ?? []
}
