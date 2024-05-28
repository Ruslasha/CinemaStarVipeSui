// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ошибки сети
enum NetworkError: Error {
    /// Невалидный URL
    case invalidURL
    /// Ошибки выполнения запроса
    case networkError(Error?)
    /// Пустая дата
    case noData
    /// Ошибки парсинга
    case decodingError(Error?)
}
