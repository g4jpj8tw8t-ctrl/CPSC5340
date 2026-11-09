//
//  BooksView.swift
//  Favorites_Completed
//
//  Created by J B on 11/3/26.
//

import SwiftUI

struct BookRowView: View {
    
    let book: BookModel
    @EnvironmentObject private var favorites: FavoritesViewModel
    
    var body: some View {
        HStack {
            Image (systemName: "book.closed")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.bookTitle)
                    .font(.headline)
                
                Text(book.bookAuthor)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                favorites.toggleFavoriteBook(book: book)
            }) {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(book.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookRowView(book: BookModel(id: 1, bookTitle: "To Kill a Mockingbird", bookAuthor: "Harper Lee", isFavorite: false))
        .environmentObject(FavoritesViewModel())
}
