//
//  BooksView.swift
//  Favorites_Completed
//
//  Created by J B on 11/3/26.
//

import SwiftUI

struct BooksView: View {
    
    @EnvironmentObject var favorites: FavoritesViewModel
    @Binding var searchText: String
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(favorites.filteredBooks(searchText: searchText)) { book in
                    BookRowView(book: book)
                }
            }
            .padding()
        }
    }
}
    
    #Preview {
        BooksView(searchText: .constant(""))
            .environmentObject(FavoritesViewModel())
    }
