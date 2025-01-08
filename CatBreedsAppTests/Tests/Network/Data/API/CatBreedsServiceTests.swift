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
    private var cache: Cache<Int, CatBreeds>!
    
    override func setUp() {
        super.setUp()
        apiManager = MockAPIManager()
        requestManager = RequestManager(apiManager: apiManager, parser: DataParser())
        cache = Cache<Int, CatBreeds>()
        service = CatBreedsService(requestManager: requestManager, cache: cache)
    }
    
    override func tearDown() {
        super.tearDown()
        apiManager = nil
        requestManager = nil
        cache = nil
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
    
    func testFetchCatBreeds_shouldTakeDataFromCache() async throws {
        let page = randomInt()
        let breeds: CatBreeds = [
            randomCatBreed()
        ]
        cache.insert(breeds, forKey: page)
        
        let result = try? await service?.fetchCatBreeds(page: page)
        XCTAssertEqual(result, breeds)
        XCTAssertTrue(apiManager.performParameters.count == 0)
    }
    
    func randomCatBreed() -> CatBreed {
        return .init(
            id: randomString(),
            name: randomString(),
            description: randomString(),
            temperament: randomString(),
            image: nil
        )
    }
    
}
