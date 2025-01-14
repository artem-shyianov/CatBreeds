import XCTest
@testable import CatBreedsApp

final class RequestManagerTests: XCTestCase {

    // MARK: - Properties

    private var requestManager: RequestManagerProtocol!
    private var apiManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()

        apiManager = MockAPIManager()
        
        requestManager = RequestManager(apiManager: apiManager)
    }

    override func tearDown() {
        super.tearDown()
        apiManager = nil
        requestManager = nil
    }

    func testRequestCats() async throws {
        let request = MockCatBreedsRequest.fetchCatBreeds
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe) else {
            XCTFail("Unexpected data")
            return
        }
        apiManager.preformResult = data
        
        let cats: CatBreeds = try await requestManager.perform(request)
        let firstCat = cats.first
        let lastCat = cats.last

        XCTAssertEqual(firstCat?.name, "Abyssinian")
        XCTAssertEqual(firstCat?.id, "abys")

        XCTAssertEqual(lastCat?.name, "Bambino")
        XCTAssertEqual(lastCat?.id, "bamb")
    }
}
