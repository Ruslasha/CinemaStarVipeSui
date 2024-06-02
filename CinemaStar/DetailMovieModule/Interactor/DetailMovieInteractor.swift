//
//  MovieDetailInteractor.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation
import Combine

/// Протокол интерактора
protocol DetailMovieInteractorProtocol {
    func fetchMovieDetailsCombine(movieId: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void)
}

/// Интерактор экрана деталей
final class DetailMovieInteractor: DetailMovieInteractorProtocol {
    
    let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovieDetailsCombine(movieId: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void) {
        networkService.getMovieDetailsCombine(id: movieId)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: { movieDetails in
                completion(.success(movieDetails))
            }
            .store(in: &cancellables)
    }
}
