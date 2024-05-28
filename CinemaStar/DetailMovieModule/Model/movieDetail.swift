// movieDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип
enum MovieType: String, Codable {
    /// Фильм
    case movie
    /// Сериал
    case tvSeries = "tv-series"
    /// Описание типа
    var typeDescription: String {
        switch self {
        case .movie:
            return "Фильм"
        case .tvSeries:
            return "Сериал"
        }
    }
}

/// Детальная информация
struct MovieDetail {
    let posterURL: String
    let name: String
    let rating: Double
    let description: String
    let year: Int
    let country: String
    let type: MovieType
    let actors: [Person]?
    let language: String
    let recommendedMovies: [SimilarMovie?]

    init(dto: MovieDTO) {
        posterURL = dto.poster.url ?? ""
        name = dto.name
        rating = dto.rating.kp
        description = dto.description
        year = dto.year
        country = dto.countries.first?.name ?? ""
        type = dto.type
        actors = dto.persons
        language = dto.spokenLanguages?.first ?? "Русский"
        recommendedMovies = dto.similarMovies ?? []
    }
}
