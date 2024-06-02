//
//  DetailMovieViewSUI.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 28.05.2024.
//

import SwiftUI

protocol DetailMovieViewProtocol {
}

struct MovieDetailedSUI: View, DetailMovieViewProtocol {

    private enum Constants {
        static let watchText = "Смотреть"
        static let starMark = "⭐"
        static let actorsTitle = "Актеры и съемочная группа"
        static let languageTitle = "Язык"
        static let recomendationTitle = "Смотрите также"
        static let movie = "Фильм"
        static let series = "Сериал"
    }

    @ObservedObject var presenter: DetailMoviePresenter

    var body: some View {

        ZStack {
            LinearGradient(colors: [.lightBrown, .darkGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                mainView
            }

            .padding()
        }
        .onAppear {
            presenter.viewDidLoad()
        }

    }

    private var mainView: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(spacing: 16) {

                if let posterURL = presenter.detailMovie?.poster, let url = URL(string: posterURL) {
                    AsyncImage(url: url) { image in
                        image
                            .image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .frame(maxWidth: 170, maxHeight: 200)
                            .padding(.leading, -15)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray)
                        .frame(width: 170, height: 200)
                        .padding(.leading, -15)
                }

                VStack(alignment: .leading) {
                    Text("")
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Text(presenter.detailMovie?.name ?? "")
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

            Text(presenter.detailMovie?.description ?? "")
                .lineLimit(5)
                .foregroundStyle(.white)

            Text(movieDataText)
                .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                .foregroundStyle(.darkGreen)

            Text(Constants.actorsTitle)
                .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                .foregroundStyle(.white)

            actorsScrollView

            VStack(alignment: .leading, spacing: 4) {
                Text(Constants.languageTitle)
                    .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.white)
                Text(presenter.detailMovie?.language ?? "")
                    .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.darkGreen)
            }

            similarMoviesView

        }

    }

    private var actorsScrollView: some View {
        ScrollView(.horizontal) {
            let gridItem = GridItem(.fixed(97))
            LazyHGrid(rows: [gridItem], spacing: 22, content: {

                ForEach(presenter.detailMovie?.actorsNames.indices ?? 0..<1, id: \.self) { index in
                    ActorViewCellSUI(actorName: presenter.detailMovie?.actorsNames[index] ?? "", actorImage: presenter.detailMovie?.actorsPhotos[index] ?? "")
                }

            })
        }
        .frame(height: 110)
    }

    private var similarMoviesView: some View {

        VStack(alignment: .leading) {
            if let movies = presenter.detailMovie?.similarMovies, !movies.isEmpty {
                Text(Constants.recomendationTitle)
                    .font(Font(UIFont.verdana(ofSize: 14) ?? .systemFont(ofSize: 14)))
                    .foregroundStyle(.white)
                ScrollView(.horizontal) {
                    let gridItem = GridItem(.fixed(248))
                    LazyHGrid(rows: [gridItem], spacing: 14, content: {
                        ForEach(movies, id: \.id) { movie in
                            RecomendationMovieView(movie: movie)
                        }
                    })
                }
                .frame(height: 248)
            }
        }
    }

    private  var movieDataText: String {
        "\(String(presenter.detailMovie?.year ?? 0000)) / \(presenter.detailMovie?.country ?? "") / \(presenter.detailMovie?.type == "movie" ? Constants.movie : Constants.series)"
    }

    private var ratingText: String {
        Constants.starMark + " " + String(format: "%0.1f", presenter.detailMovie?.rating ?? 0)
    }
}
