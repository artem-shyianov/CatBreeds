//
//  CatBreedsTestCase.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 8.1.25..
//

import XCTest
@testable import CatBreedsApp

class CatBreedsTestCase : XCTestCase {
    
    func randomString(length: Int = 5) -> String {
        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray = Array(arrayLiteral: charactersString)

        var string = ""
        for _ in 0..<length {
            string += charactersArray[Int(arc4random()) % charactersArray.count]
        }

        return string
    }
    
    func randomInt(max: Int = 10) -> Int {
        Int.random(in: 0..<max)
    }
    
    func randomCatBreed() -> CatBreed {
        CatBreed(
            id: randomString(),
            name: randomString(),
            description: randomString(),
            temperament: randomString(),
            image: nil
        )
    }
}
