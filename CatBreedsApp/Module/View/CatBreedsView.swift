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
    
    private let columns = [ GridItem(.flexible()) ]
    private let cardInsets = EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15)
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            ScrollView {
                switch viewModel.state {
                case .success(let breeds):
                    LazyVGrid(columns: columns) {
                        ForEach(breeds, id: \.id) { breed in
                            NavigationLink {
                                CatDetailView(breed: breed)
                            } label: {
                                CatBreedRow(breed: breed)
                                .padding(cardInsets)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    if !breeds.isEmpty, viewModel.hasMoreCats {
                        ProgressView("loadMore.message")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    
                case .failure:
                    VStack(spacing: 16) {
                        Text("networkError.text")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                if viewModel.breeds.isEmpty {
                    viewModel.fetchCatBreeds()
                }
            }
            .navigationTitle("navigation.title")
        }
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
