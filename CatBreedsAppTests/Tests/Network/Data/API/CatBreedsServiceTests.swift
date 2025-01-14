//
//  CatBreedsServiceTests.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25..
//

import XCTest
@testable import CatBreedsApp

final class CatBreedsServiceTests: CatBreedsTestCase {
    
    // MARK: - Properties
    
    private var service: CatBreedsService?
    private var requestManager: RequestManager!
    private var apiManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()
        apiManager = MockAPIManager()
        requestManager = RequestManager(apiManager: apiManager)

        service = CatBreedsService(requestManager: requestManager)
    }
    
    override func tearDown() {
        super.tearDown()
        apiManager = nil
        requestManager = nil

        service = nil
    }
    
    func testFetchCatBreeds() async throws {
        let page = randomInt()
        let request = MockCatBreedsRequest.fetchCatBreeds
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe) else {
            XCTFail("Unexpected data")
            return
        }
        apiManager.preformResult = data
        
        let result = try await service?.fetchCatBreeds(page: page)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 10)
        XCTAssertTrue(apiManager.performParameters.count == 1)
        
    }
}
