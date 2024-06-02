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

//        static let token = "WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2"
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
