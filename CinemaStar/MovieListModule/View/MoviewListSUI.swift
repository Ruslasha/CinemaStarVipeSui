// MoviewListSUI.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

protocol MoviesListViewProtocol {
}

struct MainMovieViewSUI: View, MoviesListViewProtocol {
    private enum Constants {
        static let title = "Смотри исторические\nфильмы на "
        static let brandName = "CINEMA STAR"
    }

    @ObservedObject var presenter: MoviesListPresenter

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
                        ForEach(presenter.movies, id: \.id) { movie in
                            MovieCellSUI(movie: .constant(movie))
                                .onTapGesture {
                                    presenter.showDetails(movieId: movie.id)
                                }
                        }
                    })
                }
                .padding()

                Spacer()
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear {
            presenter.viewDidLoad()
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
