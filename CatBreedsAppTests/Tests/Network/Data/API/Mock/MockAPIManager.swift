import XCTest
@testable import CatBreedsApp

final class MockAPIManager: APIManagerProtocol {
    var preformResult: Data = Data()
    
    struct PerformParameters {
        let request: RequestProtocol
    }
    var performParameters: [PerformParameters] = []
    func perform(_ request: RequestProtocol) async throws -> Data {
        performParameters.append(.init(request: request))
        return preformResult
    }
    
    func reset() {
        performParameters.removeAll()
    }
}
