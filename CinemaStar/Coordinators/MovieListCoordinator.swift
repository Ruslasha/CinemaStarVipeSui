// MovieListCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана со списком фильмов
final class MovieListCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController?

    // MARK: - Private Properties

    private let builder = ModuleBuilder()

    // MARK: - Initializers

    override func start() {
        guard let movieListModuleView = builder.makeMovieListModule(coordinator: self) as? MovieListViewController
        else { return }
        navigationController = UINavigationController(rootViewController: movieListModuleView)
        if let navigationController = navigationController {
            setAsRoot(navigationController)
        }
    }

    func showMovie(_ id: Int) {
        guard let detailMovieModule = builder.makeDedtailMovieModule(
            coordinator: self,
            id: id
        ) as? DetailMovieViewController
        else { return }
        navigationController?.pushViewController(detailMovieModule, animated: true)
    }

    func closeMovie() {
        guard (navigationController?.viewControllers.last as? DetailMovieViewController) != nil else {
            return
        }
        navigationController?.popViewController(animated: true)
    }
}
