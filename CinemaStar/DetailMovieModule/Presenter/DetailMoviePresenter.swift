//
//  MovieDetailsPresenter.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

/// Презентер деталей
protocol DetailMoviePresenterProtocol {
    var movieId: Int { get set }
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    func viewDidLoad()
}

/// Презентер деталей
final class DetailMoviePresenter: DetailMoviePresenterProtocol, ObservableObject {
    
    @Published var detailMovie: DetailMovie?
    
    var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorProtocol?
    var router: DetailMovieRouterProtocol?
    var movieId: Int
    
    init(movieId: Int, view: DetailMovieViewProtocol?, interactor: DetailMovieInteractorProtocol?, router: DetailMovieRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        interactor?.fetchMovieDetailsCombine(movieId: movieId) { [weak self] result in
            
            switch result {
            case .success(let movieDetails):
                DispatchQueue.main.async {
                    self?.detailMovie = movieDetails
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
