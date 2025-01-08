import Foundation
@testable import CatBreedsApp

enum MockCatBreedsRequest: RequestProtocol {
    case fetchCatBreeds

    var requestType: RequestType {
        .GET
    }

    var path: String {
        guard let path = Bundle.main.path(forResource: "CatBreedsMock", ofType: "json") else {
            return ""
        }
        return path
    }
}
