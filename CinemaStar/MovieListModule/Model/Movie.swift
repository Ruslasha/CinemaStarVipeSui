// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильма
struct Movie: Hashable {
    let posterURL: String
    let name: String
    let rating: Double
    let id: Int

    init(dto: MovieDTO) {
        posterURL = dto.poster.url ?? ""
        name = dto.name
        rating = dto.rating.kp
        id = dto.id
    }
}
