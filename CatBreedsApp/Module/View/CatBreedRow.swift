//
//  CatBreedRow.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import SwiftUI
import CachedAsyncImage

struct CatBreedRow: View {

    // MARK: - Properties

    let breed: CatBreed
    
    private let cornerRadius: CGFloat = 16
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .center) {
            breedLogoView
    
            Text(breed.name ?? "No name available")
                .font(.subheadline)
                .bold()
                .lineLimit(2)
        }
        .frame(height: 200)
    }
    
    var placeholderImage: some View {
        Rectangle().fill(.gray)
    }
    
    var breedLogoView: some View {
        ZStack {
            if let url = breed.image?.url {
                CachedAsyncImage(url:  url, placeholder: { _ in
                    placeholderImage
                }, image: {
                    Image(uiImage: $0)
                        .resizable()
                        .scaledToFit()
                })
            } else {
                placeholderImage
            }
        }.cornerRadius(cornerRadius)
    }
}

// MARK: - Previews

#Preview {
    if let breed = CatBreed.mock.first {
        CatBreedRow(breed: breed)
    }
}
