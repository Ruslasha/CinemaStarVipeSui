//
//  Assembly.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import SwiftUI

/// Билдер
final class Builder {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func createMovieListModule() {

        var viewSUI = MainMovieViewSUI(presenter: MoviesListPresenter(view: nil, interactor: nil, router: nil))
        let interactor = MoviesListInteractor()
        let router = MoviesListRouter(builder: self)
        let presenter = MoviesListPresenter(view: viewSUI, interactor: interactor, router: router)
        viewSUI.presenter = presenter
        let hostingController = UIHostingController(rootView: viewSUI)

        navigationController.pushViewController(hostingController, animated: true)

    }

    func createMovieDetailsModule(movieId: Int) {
        let interactor = DetailMovieInteractor()
        let router = DetailMovieRouter(builder: self)
        let presenter = DetailMoviePresenter(movieId: movieId, view: nil, interactor: interactor, router: router)
        let viewSUI = MovieDetailedSUI(presenter: presenter)
        presenter.view = viewSUI

        let hostingController = UIHostingController(rootView: viewSUI)
        navigationController.pushViewController(hostingController, animated: true)

    }
}
