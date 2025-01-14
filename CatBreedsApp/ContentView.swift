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
        
        return RequestManager(apiManager: apiManager)
    }()
    
    var body: some View {
        CatBreedsView(
            viewModel: .init(
                breedsFetcher: CatBreedsService(
                    requestManager: requestManager
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

