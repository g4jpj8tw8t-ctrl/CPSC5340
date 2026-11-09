//
// FavoritesView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel
    
    private var favoriteCities: [CityModel] {
        favorites.cities.filter { $0.isFavorite}
    }
    
    private var favoriteHobbies: [HobbyModel] {
        favorites.hobbies.filter { $0.isFavorite}
    }
    
    private var favoriteBooks: [BookModel] {
        favorites.books.filter { $0.isFavorite}
    }
    
    private var hasNoFavorites: Bool {
        favoriteCities.isEmpty && favoriteHobbies.isEmpty && favoriteBooks.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if hasNoFavorites {
                        VStack(spacing: 12) {
                            Image(systemName: "heart")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            Text ("No Favorites Yet")
                                .font(.headline)
                            Text("Tap a heart to save an item.")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    }
                    if !favoriteCities.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cities")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(favoriteCities) { city in
                                CityCardView(city: city)
                                
                            }
                        }
                    }
                    if !favoriteHobbies.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Hobbies")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(favoriteHobbies) { hobby in
                                HobbyRowView(hobby: hobby)
                            }
                        }
                    }
                    
                    if !favoriteBooks.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Books")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(favoriteBooks) { book in
                                BookRowView(book: book)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
