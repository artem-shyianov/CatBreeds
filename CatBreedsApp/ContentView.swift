//
//  ContentView.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25..
//

import SwiftUI

struct ContentView: View {
    
    private var requestManager: RequestManagerProtocol = {
        let apiManager = APIManager(urlSession: URLSession.shared)
        let dataParser = DataParser()
        
        return RequestManager(apiManager: apiManager, parser: dataParser)
    }()
    
    var body: some View {
        CatBreedsView(
            viewModel: .init(
                breedsFetcher: CatBreedsService(
                    requestManager: requestManager,
                    cache: Cache<Int, CatBreeds>()
                )
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

