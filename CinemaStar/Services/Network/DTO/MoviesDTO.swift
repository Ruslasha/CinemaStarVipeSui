//
//  MoviesDTO.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

///  Данные фильма
struct DocDTO: Codable {
    /// Название
    let name: String
    /// Постер
    let poster: Poster
    /// Рейтинг
    let rating: Rating
    /// id
    let id: Int
}

/// Постер
struct Poster: Codable {
    let url: String?
    let previewURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL
    }
}

/// Рейтинг
struct Rating: Codable {
    let kp, imdb: Double
    let filmCritics: Int
    let russianFilmCritics: Double
    let ratingAwait: Double?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait = "await"
    }
}

/// Ответ API фильмов
struct MoviesDTO: Codable {
    /// Данными о фильмах
    let docs: [DocDTO]
}

/// Детали фильма
struct MovieDetailsDTO: Codable {
    let id: Int
    /// Тип -
    let type: String
    /// Название
    let name: String
    /// Рейтинг
    let rating: Rating
    /// Описание
    let description: String
    /// Год
    let year: Int
    /// Постер
    let poster: Poster
    /// Страны
    let countries: [Country]
    /// Актеры
    let persons: [Person]
    /// Языки
    let spokenLanguages: [SpokenLanguage]?
    /// Похожие фильмы
    let similarMovies: [SimilarMovie]?
}

/// Тип фильма
enum MovieType: String, Codable {
    case movie
    case tvSeries = "tv-series"
}

/// Языки
struct SpokenLanguage: Codable {
    let name, nameEn: String
}

/// Актеры
struct Person: Codable {
    let id: Int
    let photo: String
    let name: String
    let enName: String?
    let description: String?
    let profession, enProfession: String
}

/// Страны сьемки фильма
struct Country: Codable {
    let name: String
}

/// Похожие фильмы
struct SimilarMovie: Codable {
    let id: Int
    let name: String
//    let enName, alternativeName: JSONAny?
    let type: String
    let poster: Poster
}

/// Структура прочих данных
//struct JSONAny: Codable {}
