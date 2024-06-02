//
//  NetworkServiceCombine.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import SwiftUI
import Combine

class NetworkService {

    private enum Constants {
        static let baseURLMovieSearch = "https://api.kinopoisk.dev/v1.4/movie/search"
        static let baseURLDetails = "https://api.kinopoisk.dev/v1.4/movie/"
        static let tokenHeader = "X-API-KEY"
    }

    func fetchMoviesList(query: String) -> AnyPublisher<[Movie], Error> {
        let urlString = Constants.baseURLMovieSearch
        guard var urlComponents = URLComponents(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        urlComponents.queryItems = [URLQueryItem(name: "query", value: query)]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        guard let token = KeychainManager.shared.loadToken() else {
            print("No token")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        request.addValue(token, forHTTPHeaderField: Constants.tokenHeader)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map (\.data)
            .decode(type: MoviesDTO.self, decoder: JSONDecoder())
            .map { $0.docs.map { Movie(poster: $0.poster.url, name: $0.name, rating: $0.rating.kp, id: $0.id) }}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getMovieDetailsCombine(id: Int) -> AnyPublisher<DetailMovie, Error> {
        let urlString = Constants.baseURLDetails + "\(id)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = KeychainManager.shared.loadToken() else {
            print("No token")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        request.addValue(token, forHTTPHeaderField: Constants.tokenHeader)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieDetailsDTO.self, decoder: JSONDecoder())
            .map { result in
                DetailMovie(
                    id: result.id,
                    poster: result.poster.url,
                    name: result.name,
                    rating: result.rating.kp,
                    description: result.description,
                    year: result.year,
                    country: result.countries.first?.name,
                    type: result.type,
                    actorsPhotos: result.persons.map(\.photo),
                    actorsNames: result.persons.map(\.name),
                    language: result.spokenLanguages?.first?.name,
                    similarMovies: result.similarMovies
                )
            }
            .eraseToAnyPublisher()
    }

    func getMovieDetailsCache(id: Int) -> AnyPublisher<DetailMovie, Error> {

        var savedMovieDetailsItems: [MovieDetailsItem] = []
        CacheService.shared.fetchMovieDetailsItems { movieDetailsItems, _ in
            if let movieDetailsItems = movieDetailsItems {
                savedMovieDetailsItems = movieDetailsItems
            } else {
                savedMovieDetailsItems = []
            }
        }

        for detailsItem in savedMovieDetailsItems {
            if detailsItem.id == id {
                return Just(DetailMovie(
                    id: detailsItem.id,
                    poster: detailsItem.poster,
                    name: detailsItem.name,
                    rating: detailsItem.rating,
                    description: detailsItem.movieDescription,
                    year: detailsItem.year,
                    country: detailsItem.country,
                    type: detailsItem.type,
                    actorsPhotos: detailsItem.actorsPhotos,
                    actorsNames: detailsItem.actorsNames,
                    language: detailsItem.language,
                    similarMovies: detailsItem.similarMovies
                ))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            }
        }

        let urlString = Constants.baseURLDetails + "\(id)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = KeychainManager.shared.loadToken() else {
            print("No token")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        request.addValue(token, forHTTPHeaderField: Constants.tokenHeader)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieDetailsDTO.self, decoder: JSONDecoder())
            .map { result in
                DetailMovie(
                    id: result.id,
                    poster: result.poster.url,
                    name: result.name,
                    rating: result.rating.kp,
                    description: result.description,
                    year: result.year,
                    country: result.countries.first?.name,
                    type: result.type,
                    actorsPhotos: result.persons.map(\.photo),
                    actorsNames: result.persons.map(\.name),
                    language: result.spokenLanguages?.first?.name,
                    similarMovies: result.similarMovies
                )
            }
            .handleEvents(receiveOutput: { movieDetails in
                CacheService.shared.saveMovieDetailsItem(MovieDetailsItem(
                    id: movieDetails.id,
                    poster: movieDetails.poster,
                    name: movieDetails.name,
                    rating: movieDetails.rating,
                    description: movieDetails.description,
                    year: movieDetails.year,
                    country: movieDetails.country,
                    type: movieDetails.type,
                    actorsPhotos: movieDetails.actorsPhotos,
                    actorsNames: movieDetails.actorsNames,
                    language: movieDetails.language,
                    similarMovies: movieDetails.similarMovies
                ))
            })
            .eraseToAnyPublisher()
    }

    static func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let imageURL = URL(string: urlString) else { return Just(nil).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: imageURL)
            .map { data, _ in
                UIImage(data: data)
            }
            .catch { _ in
                Just(nil).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
