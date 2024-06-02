//
//  MovieistRouter.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import UIKit

/// Протокол роутера
protocol MoviesListRouterProtocol {
    var builder: Builder { get set }
    func showMovieDetail(from view: MoviesListViewProtocol, movieID: Int)
}

/// Роутер экрана списка
final class MoviesListRouter: MoviesListRouterProtocol {
    var builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
    
    func showMovieDetail(from view: MoviesListViewProtocol, movieID: Int) {
        builder.createMovieDetailsModule(movieId: movieID)
    }
}
