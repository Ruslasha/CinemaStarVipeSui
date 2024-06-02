//
//  CacheService.swift
//  CinemaStar
//
//  Created by Руслан Абрамов on 02.06.2024.
//

import Foundation
import SwiftData

final class CacheService {

    static var shared = CacheService()

    var MovieContainer: ModelContainer = {
        let schema = Schema([
            MovieItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("\(error)")
        }
    }()

    var MovieDetailsContainer: ModelContainer = {
        let schema = Schema([
            MovieDetailsItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("\(error)")
        }
    }()

    var movieContext: ModelContext
    var movieDetailsContext: ModelContext

    init() {
        movieContext = ModelContext(MovieContainer)
        movieDetailsContext = ModelContext(MovieDetailsContainer)
    }

    func saveMovieItem(_ item: MovieItem) {
        movieContext.insert(item)
    }

    func deleteWatchMovieItem(_ item: MovieItem) {
        let itemToBeDeleted = item
        movieContext.delete(itemToBeDeleted)
    }

    func fetchMovieItems(onCompletion: @escaping([MovieItem]?, Error?)->(Void)) {
        let descriptor = FetchDescriptor<MovieItem>(sortBy: [SortDescriptor<MovieItem>(\.id)])

        do {
            let data = try movieContext.fetch(descriptor)
            onCompletion(data,nil)
        } catch {
            onCompletion(nil,error)
        }
    }

    func saveMovieDetailsItem(_ item: MovieDetailsItem) {
        movieDetailsContext.insert(item)
    }

    func deleteWatchMovieDetailsItem(_ item: MovieDetailsItem) {
        let itemToBeDeleted = item
        movieDetailsContext.delete(itemToBeDeleted)
    }

    func fetchMovieDetailsItems(onCompletion: @escaping([MovieDetailsItem]?, Error?)->(Void)) {
        let descriptor = FetchDescriptor<MovieDetailsItem>(sortBy: [SortDescriptor<MovieDetailsItem>(\.id)])

        do {
            let data = try movieDetailsContext.fetch(descriptor)
            onCompletion(data,nil)
        } catch {
            onCompletion(nil,error)
        }
    }
}
