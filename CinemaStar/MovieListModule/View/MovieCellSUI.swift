// MovieCellSUI.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct MovieCellSUI: View {
    @State var movie: Movie

    private enum Constants {
        static let starMark = "⭐ "
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(.orig)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(movie.name)
            Text(Constants.starMark + rating)
        }
        .foregroundStyle(.white)
    }

    private var rating: String {
        String(format: "%0.1f", movie.rating)
    }
}

#Preview {
    MovieCellSUI(
        movie: Movie(dto: MovieDTO(
            id: 2,
            poster: Poster(
                url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"
            ),
            name: "Форсаж",
            rating: RatingKP(kp: 9.896),
            description: "Description",
            year: 2023,
            countries: [],
            type: .movie,
            persons: nil,
            spokenLanguages: [],
            similarMovies: []
        ))
    )
    .background(Color.gray)
}
