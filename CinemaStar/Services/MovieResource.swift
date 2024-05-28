// MovieResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ресурс для фильмов
struct MovieResource: APIResource {
    typealias ModelType = Response

    var id: Int?

    var methodPath: String {
        guard let id = id else {
            return "/v1.4/movie/search"
        }
        return "/v1.4/movie/\(id)"
    }
}

/// Ресурс для детальной информации
struct MovieDetailResource: APIResource {
    typealias ModelType = MovieDTO

    var id: Int?

    var methodPath: String {
        guard let id = id else {
            return "/v1.4/movie/search"
        }
        return "/v1.4/movie/\(id)"
    }
}
