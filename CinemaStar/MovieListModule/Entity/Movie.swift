//
//  Movie.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

/// Модель для экрана списка
struct Movie: Equatable, Codable {
    /// Постер
    let poster: String?
    /// Название
    let name: String
    /// Рейтинг
    let rating: Double
    /// id
    let id: Int
}
