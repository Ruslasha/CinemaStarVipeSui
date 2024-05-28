// APIResources.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL? {
        var components = URLComponents(string: "https://api.kinopoisk.dev")
        components?.path = methodPath
        components?.queryItems = [
            URLQueryItem(name: "query", value: "История"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "page", value: "1")
        ]

        return components?.url
    }
}
