//
//  CatBreedsView.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import SwiftUI

struct CatBreedsView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: CatBreedsViewModel
    
    private let columns = Array(repeating: GridItem(), count: 2)
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .failure:
                    VStack(spacing: 16) {
                        Text(localizedString("networkError.text"))
                            .font(.title3)
                            .multilineTextAlignment(.center)
                        Button("Refresh", action: {
                            Task {
                                await viewModel.fetchCatBreeds()
                            }
                        })
                    }
                    .padding()
                case .success(let breeds):
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(breeds) { breed in
                                CatBreedRow(breed: breed)
                                .task {
                                    if viewModel.hasReachedEnd(of: breed) && viewModel.hasMoreCats {
                                       await viewModel.fetchMoreBreeds()
                                    }
                                }
                            }
                        }
                        
                        if !viewModel.breeds.isEmpty, viewModel.hasMoreCats {
                            ProgressView("loadMore.message")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }.refreshable {
                        viewModel.reset()
                        Task {
                            await viewModel.fetchCatBreeds()
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchCatBreeds()
            }
            .navigationTitle(localizedString("navigation.title"))
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Preview

struct CatBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedsView(
            viewModel: CatBreedsViewModel(
                breedsFetcher: MockCatBreedsFetcher()
            )
        )
    }
}
