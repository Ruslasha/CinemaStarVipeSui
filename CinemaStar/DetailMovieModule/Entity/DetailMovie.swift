//
//  MovieDetails.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

/// Детали фильма
struct DetailMovie {
    var id: Int
    /// Постер
    var poster: String?
    /// Название
    var name: String
    /// Рейтинг
    var rating: Double
    /// Описание
    var description: String
    /// Год
    var year: Int
    /// Страна
    var country: String?
    /// Тип фильма
    var type: String
    /// Фото актеров
    var actorsPhotos: [String]
    /// Имена актеров
    var actorsNames: [String]
    /// Язык
    var language: String?
    /// Похожие фильмы
    var similarMovies: [SimilarMovie]?
}
