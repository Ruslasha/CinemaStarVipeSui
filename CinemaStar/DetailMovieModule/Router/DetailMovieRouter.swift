//
//  MovieDetailsRouter.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 31.05.2024.
//

import Foundation

/// Протокол роутера
protocol DetailMovieRouterProtocol {
    var builder: Builder { get set }
}
/// Роутер деталей
final class DetailMovieRouter: DetailMovieRouterProtocol {
    var builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
}
