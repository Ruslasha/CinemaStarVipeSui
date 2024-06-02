//
//  MovieItem.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 02.06.2024.
//

import Foundation
import SwiftData

/// Модель фильма для SwiftData
@Model
final class MovieItem: Identifiable {
    /// Постер
    let poster: String?
    /// Название
    let name: String
    /// Рейтинг
    let rating: Double
    /// id
    let id: Int

    init(poster: String?, name: String, rating: Double, id: Int) {
        self.poster = poster
        self.name = name
        self.rating = rating
        self.id = id
    }
}
