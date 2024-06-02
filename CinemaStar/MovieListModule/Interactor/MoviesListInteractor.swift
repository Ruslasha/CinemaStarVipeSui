//
//  MoviesListInteractor.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation
import Combine

/// Протокол интерактора
protocol MoviesListInteractorProtocol {
    func fetchMoviesCombine(category: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

/// Интерактор экрана списка
final class MoviesListInteractor: MoviesListInteractorProtocol {
    
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMoviesCombine(category: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkService.fetchMoviesList(query: category)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: { movies in
                completion(.success(movies))
            }
            .store(in: &cancellables)
    }
}
