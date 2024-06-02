//
//  MoviesListPresenter.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

/// Протокол презентера
protocol MoviesListPresenterProtocol {
    var view: MoviesListViewProtocol? { get set }
    var interactor: MoviesListInteractorProtocol? { get set }
    var router: MoviesListRouterProtocol? { get set }
    
    func viewDidLoad()
    func showDetails(movieId: Int)
}


/// Презентер списка
final class MoviesListPresenter: MoviesListPresenterProtocol, ObservableObject {
    var view: MoviesListViewProtocol?
    var interactor: MoviesListInteractorProtocol?
    var router: MoviesListRouterProtocol?
    
    @Published var movies: [Movie] = []
    
    init(view: MoviesListViewProtocol?, interactor: MoviesListInteractorProtocol?, router: MoviesListRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor?.fetchMoviesCombine(category: "История", completion: { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.movies = movies
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func showDetails(movieId: Int) {
        if let view = view {
            router?.showMovieDetail(from: view, movieID: movieId)
        }
    }
}
