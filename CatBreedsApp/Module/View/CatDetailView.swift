//
//  CatDetailView.swift
//  CatBreedsApp
//
//  Created by Artem Shyianov on 7.1.25.
//

import SwiftUI
import CachedAsyncImage

struct CatDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let breed: CatBreed
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    if let url = breed.image?.url {
                        CachedAsyncImage(url: url, placeholder: { _ in
                            Color.gray
                        }, image: {
                            Image(uiImage: $0)
                                .resizable()
                                .scaledToFit()
                        })
                    }
                    breedContent
                }
            }
            .navigationBarItems(trailing: Button(localizedString("dismiss.title"), action: {
                dismiss()
            }))
            .navigationTitle(breed.name ?? "")
        }
    }
    

    
    var breedContent: some View {
       VStack(alignment: .leading) {
           Text(breed.temperament ?? "No temperament available")
               .font(.caption)
               .foregroundColor(.secondary)
           Spacer()
           Text(detailsText)
               .font(.body)
               .foregroundColor(.primary)
       }
       .padding()
   }
    
    var detailsText: String {
        guard let description = breed.description else {
            return "No description available"
        }
        return description
    }
    
}


// MARK: - Preview

struct CatBreedsDetails_Previews: PreviewProvider {
    static var previews: some View {
        if let breed = CatBreed.mock.first {
            CatDetailView(breed: breed)
        }
    }
}
