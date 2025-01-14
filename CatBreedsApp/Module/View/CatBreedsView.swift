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
    @State private var selectedBread: CatBreed? = nil

    private let columns = Array(repeating: GridItem(), count: 2)
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failure:
                    VStack(spacing: 16) {
                        Text("networkError.text")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                case .success(let breeds):
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(breeds) { breed in
                                CatBreedRow(breed: breed)
                                .onTapGesture {
                                    selectedBread = breed
                                }
                                .task {
                                    viewModel.fetchMoreBreedsIfNeeded(with: breed)
                                }
                            }
                        }
                        
                        if !breeds.isEmpty, viewModel.hasMoreCats {
                            ProgressView("loadMore.message")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }.sheet(item: self.$selectedBread) { breed in
                        CatDetailView(breed: breed)
                    }
                }
            }
            .task {
                viewModel.fetchCatBreeds()
            }
            .navigationTitle("navigation.title")
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Preview

#Preview {
    CatBreedsView(
        viewModel: CatBreedsViewModel(
            breedsFetcher: MockCatBreedsFetcher()
        )
    )
}
