// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Протокол для сети
protocol NetworkServiceProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func getDetailMovie(by id: Int, completion: @escaping (Result<MovieDetail, Error>) -> ())
    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

/// Сеть
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private Properties

    private let decoder = JSONDecoder()

    // MARK: - Initialization

    init() {}

    // MARK: - Private Methods

    private func transToMovies(_ response: Response) -> [Movie] {
        response.docs.map { Movie(dto: $0) }
    }

    private func getData<T: Codable>(
        request: URLRequest?,
        parseProtocol: T.Type,
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        guard let request else { return }
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self else {
                return
            }
            guard let data = data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let parsedData = try self.decoder.decode(parseProtocol, from: data)
                completion(.success(parsedData))
            } catch { completion(.failure(error)) }
        }
        task.resume()
    }

    private var resource = MovieResource()
    private lazy var request = APIRequest(resource: resource)
    private var imageRequest: ImageRequest?
    private var resourceDetail = MovieDetailResource()
    private lazy var detailRequest = APIRequest(resource: resourceDetail)

    func getMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        request.execute { result in
            switch result {
            case let .some(movies):
                completion(.success(movies.docs.map { Movie(dto: $0) }))
            case .none:
                break
            }
        }
    }

    func getDetailMovie(by id: Int, completion: @escaping (Result<MovieDetail, Error>) -> ()) {
        resourceDetail.id = id
        detailRequest.execute { result in
            switch result {
            case let .some(movie):
                completion(.success(MovieDetail(dto: movie)))
            case .none:
                break
            }
        }
    }

    func loadImage(by urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        imageRequest = ImageRequest(url: url)
        imageRequest?.execute { result in
            switch result {
            case let .some(image):
                completion(.success(image))
            case .none:
                break
            }
        }
    }
}
