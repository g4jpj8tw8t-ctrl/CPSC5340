//
// CityCardView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

struct CityCardView: View {
    
    let city : CityModel
    @EnvironmentObject private var favorites : FavoritesViewModel
    
    var body: some View {
        HStack {
            Text(city.cityName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.black.opacity(0.35))
            
            Spacer()
            
            Button {
                favorites.toggleFavoriteCity(city: city)
            } label: {
                Image(
                    systemName: city.isFavorite
                    ? "heart.fill"
                    : "heart"
                )
                .padding(6)
                .foregroundStyle(city.isFavorite ? .red : .white)
                .background(Color.black.opacity(0.35))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, alignment: .bottom)
        .frame(height: 140, alignment: .bottom)
        .background {
            Image(city.cityImage)
                .resizable()
                .scaledToFill()
        }
        .clipped()
        .shadow(radius: 3)
    }
}

#Preview {
    CityCardView(city: CityModel(id: 1, cityName: "Amsterdam", cityImage: "amsterdam", isFavorite: false))
}
