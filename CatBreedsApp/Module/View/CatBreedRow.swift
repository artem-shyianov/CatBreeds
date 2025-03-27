//
//  CatBreedRow.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import SwiftUI
import CachedAsyncImage

struct CatBreedRow: View {

    let breed: CatBreed
    
    private let cardDetailsEdges = EdgeInsets(top: 3, leading: 15, bottom: 0, trailing: 15)
    
    // MARK: - Body

    var body: some View {
        VStack {
            logoImageView
                .frame(height: 256)
                .clipped()
            cardDetailsView
        }
        .background(Color.white)
        .cornerRadius(14)
        .shadow(radius: 10, x: 2, y: 2)
    }
    
    var logoImageView: some View {
        ZStack {
            AsyncImage(url: breed.image?.url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
            } placeholder: {
                placeholderImage
            }
        }
    }
    
    var dividerView: some View {
        Divider()
            .frame(height: 6)
    }
    
    var cardDetailsView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(breed.name ?? "No name available")
                .font(.title2)
                .bold()
            Text(breed.description ?? "")
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(2)
            dividerView
            
            
            HStack {
                Text("Country: \(breed.origin ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                Spacer()
                Text("Intelligence: \(breed.intelligence)")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .frame(minHeight: 120)
        .padding(cardDetailsEdges)
    }
    
    var placeholderImage: some View {
        Rectangle().fill(.gray)
    }
}

// MARK: - Previews

#Preview {
    if let breed = CatBreed.mock.first {
        CatBreedRow(breed: breed)
    }
}
