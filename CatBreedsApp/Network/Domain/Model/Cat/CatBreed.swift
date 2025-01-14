//
//  CatBreed.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import Foundation

typealias CatBreeds = [CatBreed]

// MARK: - Cat

struct CatBreed: Codable, Identifiable {
    let id: String
    let name: String?
    let description: String?
    let temperament: String?
    let image: CatBreedImage?
    
    public init(
        id: String,
        name: String?,
        description: String?,
        temperament: String?,
        image: CatBreedImage?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.temperament = temperament
        self.image = image
    }
}


// MARK: - CatImage

struct CatBreedImage: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String?
    
    public init(
        id: String?,
        width: Int?,
        height: Int?,
        url: String?
    ) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
    }
}

// MARK: - Hashable

extension CatBreed: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CatBreed, rhs: CatBreed) -> Bool {
        lhs.id == rhs.id
    }
}
