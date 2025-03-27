//
//  CatDetailView.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import SwiftUI
import CachedAsyncImage

struct CatDetailView: View {
    
    let breed: CatBreed
    
    var body: some View {
        ScrollView {
            logoImageView
            .frame(height: 366)
            .clipped()
            breedContent
                .background(Color.white)
        }
        .navigationTitle(breed.name ?? "")
    }
    
    var logoImageView: some View {
        AsyncImage(url: breed.image?.url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                
        } placeholder: {
            placeholderImage
        }
    }
    
    var dividerView: some View {
        Divider()
            .frame(height: 6)
    }
    
    var placeholderImage: some View {
        Rectangle().fill(.gray)
    }
    
    var breedContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Country: \(breed.origin ?? "")")
                .font(.body)
            Text("Life span: \(breed.lifeSpan ?? "") years")
                .font(.body)
            Text("Intelligence: \(breed.intelligence)")
                .font(.body)
            Text("Adaptability: \(breed.adaptability)")
                .font(.body)
            dividerView
            Text("Cat temperament:")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(breed.temperaments, id: \.self) { temperament in
                        Button {
                            
                        } label: {
                            Text(temperament)
                                .font(.headline)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .frame(maxHeight: 30)
                    }
                }
            }
            .scrollIndicators(.hidden)
    
            dividerView
            Text("Cat description:")
                .font(.title2)
                .bold()
            Text(detailsText)
                .font(.body)
                .foregroundColor(.primary)
       }
       .padding(15)
   }
    
    var detailsText: String {
        guard let description = breed.description else {
            return "No description available"
        }
        return description
    }
    
}


// MARK: - Preview

#Preview {
    if let breed = CatBreed.mock.first {
        CatDetailView(breed: breed)
    }
}
