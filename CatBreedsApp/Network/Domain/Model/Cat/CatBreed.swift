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
    let origin: String?
    let intelligence: Int
    let adaptability: Int
    let lifeSpan: String?
    let description: String?
    let temperament: String?
    let image: CatBreedImage?
    
    public init(
        id: String,
        name: String?,
        origin: String?,
        intelligence: Int,
        adaptability: Int,
        lifeSpan: String?,
        description: String?,
        temperament: String?,
        image: CatBreedImage?
    ) {
        self.id = id
        self.name = name
        self.origin = origin
        self.description = description
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.intelligence = intelligence
        self.adaptability = adaptability
        self.image = image
    }
    
    var temperaments: [String] {
        temperament?.split(separator: ",").map { String($0) } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case intelligence
        case adaptability
        case lifeSpan = "life_span"
        case description
        case temperament
        case image
    }
}


// MARK: - CatImage

struct CatBreedImage: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: URL?
    
    public init(
        id: String?,
        width: Int?,
        height: Int?,
        url: URL?
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
