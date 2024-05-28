// MovieListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol MovieListViewModelProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

/// Вью модель экрана с фильмами
final class MovieListViewModel: MovieListViewModelProtocol {
    private var networkService: NetworkServiceProtocol
    private var movieCoordinator: MovieListCoordinator

    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        networkService.getMovies(completion: completion)
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        networkService.loadImage(by: urlString, completion: completion)
    }

    func showDetailMovie(id: Int) {
        movieCoordinator.showMovie(id)
    }

    init(networkService: NetworkServiceProtocol, coordinator: MovieListCoordinator) {
        self.networkService = networkService
        movieCoordinator = coordinator
    }
}
