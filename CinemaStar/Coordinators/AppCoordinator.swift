// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoordinator {
    override func start() {
        toMain()
    }

    private func toMain() {
        let movieListCoordinator = MovieListCoordinator()
        add(coordinator: movieListCoordinator)
        movieListCoordinator.start()
    }
}
