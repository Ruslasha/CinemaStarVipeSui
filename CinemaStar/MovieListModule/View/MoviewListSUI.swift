// MoviewListSUI.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct MainMovieViewSUI: View {
    private enum Constants {
        static let title = "Смотри исторические\nфильмы на "
        static let brandName = "CINEMA STAR"
        static let sideInset = 16.0
        static let interItemInset = 18.0
        static let lineSpacing = 14.0
        static let cellRatio = 248.0 / 170.0
    }

    var mockMovies: [Movie] {
        var outputArray = [Movie]()
        for i in 0 ... 9 {
            outputArray.append(Movie(dto: MovieDTO(
                id: i,
                poster: Poster(
                    url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"
                ),
                name: "Furious 77",
                rating: RatingKP(kp: 8.856),
                description: "some some some",
                year: 2023,
                countries: [],
                type: .movie,
                persons: nil,
                spokenLanguages: [],
                similarMovies: []
            )))
        }
        return outputArray
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.lightBrown, .darkGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text(attributedTitle)
                    Spacer()
                }
                .padding()
                ScrollView {
                    let gridItem = GridItem()
                    LazyVGrid(columns: [gridItem, gridItem], spacing: 14, content: {
                        ForEach(mockMovies, id: \.self) { movie in
                            MovieCellSUI(movie: movie)
                                .onTapGesture {
                                    print(movie.id)
                                }
                                .frame(width: 170, height: 220)
                        }
                    })
                }
                .padding()

                Spacer()
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }

    var attributedTitle: AttributedString {
        var watchText = AttributedString(Constants.title)
        watchText.font = .verdana(ofSize: 20)
        var brandText = AttributedString(Constants.brandName)
        brandText.font = .verdanaBold(ofSize: 20)
        watchText.append(brandText)
        return watchText
    }
}

#Preview {
    MainMovieViewSUI()
}
