//
//  DetailMovieViewSUI.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 28.05.2024.
//

import SwiftUI

struct MovieDetailedSUI: View {

    private enum Constants {
        static let watchText = "Смотреть"
        static let starMark = "⭐"
        static let actorsTitle = "Актеры и съемочная группа"
        static let languageTitle = "Язык"
        static let recomendationTitle = "Смотрите также"
    }

    @State var movieDetail: MovieDetail

    var body: some View {

        ZStack {
            LinearGradient(colors: [.lightBrown, .darkGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                mainView
            }

            .padding()
        }

    }

    private var mainView: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(spacing: 16) {

                Image(.orig)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(height: 200)
                    .frame(minWidth: 0, maxWidth: .infinity)

                VStack(alignment: .leading) {
                    Text("")
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Text(movieDetail.name)
                        .font(Font(UIFont.verdana(ofSize: 18) ?? .systemFont(ofSize: 18)))

                    Text(ratingText)
                        .font(Font(UIFont.verdana(ofSize: 16) ?? .systemFont(ofSize: 16)))

                }
                .foregroundStyle(.white)
            }

            Button(action: {
                print(Constants.watchText)
            }, label: {
                HStack {
                    Spacer()
                    Text(Constants.watchText)
                        .font(Font(UIFont.verdana(ofSize: 16) ?? .systemFont(ofSize: 16)))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.darkGreen)
                )

            })

            Text(movieDetail.description)
                .lineLimit(5)
                .foregroundStyle(.white)

            Text(movieDataText)
                .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                .foregroundStyle(.darkGreen)

            Text(Constants.actorsTitle)
                .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                .foregroundStyle(.white)
            if movieDetail.actors?.isEmpty != nil {
                actorsScrollView
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(Constants.languageTitle)
                    .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.white)
                Text(movieDetail.language)
                    .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.darkGreen)
            }
            if !movieDetail.recommendedMovies.isEmpty {
                similarMoviesView
            }
        }

    }

    private var actorsScrollView: some View {
        ScrollView(.horizontal) {
            let gridItem = GridItem(.fixed(97))
            LazyHGrid(rows: [gridItem], spacing: 22, content: {

                ForEach(movieDetail.actors ?? mockActors, id: \.self) { person in
                    ActorViewCellSUI(person: person)
                }

            })
        }
        .frame(height: 97)
    }

    private var similarMoviesView: some View {
        VStack(alignment: .leading) {
            Text(Constants.recomendationTitle)
                .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                .foregroundStyle(.white)
            ScrollView(.horizontal) {
                let gridItem = GridItem(.fixed(248))
                LazyHGrid(rows: [gridItem], spacing: 14, content: {
                    ForEach(movieDetail.recommendedMovies, id: \.self) { movie in
                        RecomendationMovieView(movie: movie)
                    }
                })
            }
            .frame(height: 248)
        }
    }

    private  var movieDataText: String {
        "\(movieDetail.year) / \(movieDetail.country) / \(movieDetail.type.typeDescription)"
    }

    private var ratingText: String {
        Constants.starMark + " " + String(format: "%0.1f", movieDetail.rating)
    }

    private var mockActors: [Person] {
            var outputArray = [Person]()
            for i in 0...9 {
                outputArray.append(Person(photo: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig", name: "Actor Name\(i)"))
            }
            return outputArray
        }

    }

    #Preview {
        MovieDetailedSUI(movieDetail:
                            MovieDetail(dto:
                                            MovieDTO(id: 2,
                                                     poster: Poster(url: "https://image.openmoviedb.com/kinopoisk-images/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/orig"),
                                                     name: "Furious 77",
                                                     rating: RatingKP(kp: 9.892),
                                                     description: "Deckard Shaw seeks revenge against Dominic Toretto and his family for his comatose brother. In the five years since the events of Fast and Furious 6, street racer Dominic Toretto, former cop, Brian O'Conner, racer Letty Ortiz, and the crew have lived peaceful years after Owen Shaw's demise.",
                                                     year: 2023,
                                                     countries: [Country(name: "Russia")],
                                                     type: .movie,
                                                     persons: [Person(photo: "https://image.openmoviedb.com/kinopoisk-images/10768063/aaf31049-6437-4022-bb67-4fad82773cff/orig", name: "Verona")],
                                                     spokenLanguages: ["Russian"],
                                                     similarMovies: [SimilarMovie(name: "Furious 948", poster: Poster(url: "https://image.openmoviedb.com/kinopoisk-images/10768063/aaf31049-6437-4022-bb67-4fad82773cff/orig"))])))
    }
