// movieDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ
struct Response: Codable {
    let docs: [MovieDTO]
}

/// Модель дто
struct MovieDTO: Codable {
    let id: Int
    let poster: Poster
    let name: String
    let rating: RatingKP
    let description: String
    let year: Int
    let countries: [Country]
    let type: MovieType
    let persons: [Person]?
    let spokenLanguages: [String]?
//    let spokenLanguages: [SpokenLanguages]?
    let similarMovies: [SimilarMovie]?
}

/// Постер
struct Poster: Codable {
    let url: String?
}

/// Страна
struct Country: Codable {
    let name: String
}

/// Язык
struct SpokenLanguages: Codable {
    let name: String
}

/// Рейтинг
struct RatingKP: Codable {
    let kp: Double
}

/// Актеры
struct Person: Codable {
    let photo: String
    let name: String?
}

/// Похожие фильмы
struct SimilarMovie: Codable {
    let name: String
    let poster: Poster
}
