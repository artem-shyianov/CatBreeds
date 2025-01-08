//
//  DataParserTests.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25..
//

import XCTest
@testable import CatBreedsApp

final class DataParserTests: XCTestCase {
    
    // MARK: - Properties
    
    private var dataParser: DataParserProtocol!
    
    override func setUp() {
        super.setUp()
        let jsonDecoder = JSONDecoder()
        dataParser = DataParser(jsonDecoder: jsonDecoder)
    }
    
    override func tearDown() {
        super.tearDown()
        
        dataParser = nil
    }
    
    func testParse() throws {
        guard
            let url = Bundle.main.url(forResource: "CatBreedsMock", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            XCTFail("Unexpeced data")
            return
        }
        
        let result = try? dataParser.parse(data: data) as CatBreeds
        XCTAssertNotNil(result)
        XCTAssertFalse(result?.isEmpty ?? false)
    }
}
