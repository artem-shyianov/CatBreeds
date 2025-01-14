import XCTest
@testable import CatBreedsApp

@MainActor
final class CatBreedsViewModelTests: CatBreedsTestCase {

    // MARK: - Properties

    private var viewModel: CatBreedsViewModel!
    private var breedsFetcher: MockCatBreedsFetcher!
    
    override func setUp() {
        super.setUp()

        breedsFetcher = MockCatBreedsFetcher()
        viewModel = CatBreedsViewModel(breedsFetcher: breedsFetcher)
    }

    override func tearDown() {
        breedsFetcher = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchCatsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
        await viewModel.fetchCatBreeds()
        XCTAssertFalse(viewModel.isLoading, "The view model should be loading, but it isn't")
    }

    func testUpdatePageOnFetchMoreCats() async {
        XCTAssertEqual(
            viewModel.page,
            0,
            "the view model's page property should be 0 before fetching, but it's \(viewModel.page)"
        )

        let breed = randomCatBreed()
        viewModel.breeds = [breed]
        await viewModel.fetchMoreBreedsIfNeeded(with: breed)

        XCTAssertEqual(
            viewModel.page,
            1,
            "the view model's page property should be 1 after fetching, but it's \(viewModel.page)"
        )
    }

    func testFetchCatsEmptyResponse() async {
        viewModel = CatBreedsViewModel(
            breedsFetcher: EmptyResponseCatsFetcherMock()
        )

        await viewModel.fetchCatBreeds()

        XCTAssertFalse(
            viewModel.hasMoreCats,
            "hasMorCats should be false with an empty response, but it's true"
        )

        XCTAssertFalse(viewModel.isLoading, "The view model should be loading, but it isn't")
    }
}

struct EmptyResponseCatsFetcherMock: CatBreedsFetcher {
    func fetchCatBreeds(page: Int) async -> CatBreeds {
        []
    }
}
