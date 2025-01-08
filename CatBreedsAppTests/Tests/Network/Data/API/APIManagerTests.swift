//
//  APIManagerTests.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import XCTest
@testable import CatBreedsApp

final class APIManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    private var apiManager: APIManagerProtocol?
    private var urlSession: MockURLSession?
    
    override func setUp() {
        super.setUp()
        
        urlSession = MockURLSession()
        apiManager = APIManager(urlSession: urlSession!)
    }
    
    override func tearDown() {
        super.tearDown()
        
        urlSession = nil
        apiManager = nil
    }
    
    func testPerform_returnsData_statusCode200() async throws {
        let data = Data()
        let url = URL(string: "http://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        urlSession?.stubDataResult = (data, response)
        let request = MockCatBreedsRequest.fetchCatBreeds
        let result = try await apiManager?.perform(request)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, data)
    }
    
    func testPerform_returnsData_statusCodeError() async throws {
        let data = Data()
        let url = URL(string: "http://example.com")!
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
        
        urlSession?.stubDataResult = (data, response)
        let request = MockCatBreedsRequest.fetchCatBreeds
        let result = try? await apiManager?.perform(request)
        XCTAssertNil(result)
    }
}

final class MockURLSession : URLSessionProtocol {
    
    var stubDataResult: (Data, URLResponse) = (Data(), URLResponse())
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return stubDataResult
    }
}
