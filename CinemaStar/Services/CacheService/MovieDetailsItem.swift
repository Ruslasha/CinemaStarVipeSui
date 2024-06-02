//
//  MovieDetailsItem.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 02.06.2024.
//

import Foundation
import SwiftData

/// Модель деталей для SwiftData
@Model
final class MovieDetailsItem: Identifiable {
    var id: Int
    /// Постер
    var poster: String?
    /// Название
    var name: String
    /// Рейтинг
    var rating: Double
    /// Описание
    var movieDescription: String
    /// Год
    var year: Int
    /// Страна
    var country: String?
    /// Тип фильма
    var type: String
    /// Фото актеров
    var actorsPhotos: [String]
    /// Актеры
    var actorsNames: [String]
    /// Язык
    var language: String?
    /// Похожие фильмы
    var similarMovies: [SimilarMovie]?
    
    init(id: Int, poster: String? = nil, name: String, rating: Double, description: String, year: Int, country: String? = nil, type: String, actorsPhotos: [String], actorsNames: [String], language: String? = nil, similarMovies: [SimilarMovie]? = nil) {
        self.id = id
        self.poster = poster
        self.name = name
        self.rating = rating
        self.movieDescription = description
        self.year = year
        self.country = country
        self.type = type
        self.actorsPhotos = actorsPhotos
        self.actorsNames = actorsNames
        self.language = language
        self.similarMovies = similarMovies
    }
}
