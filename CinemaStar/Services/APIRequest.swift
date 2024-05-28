// APIRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Запрос
class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        do {
            let responce = try decoder.decode(Resource.ModelType.self, from: data)
            return responce
        } catch {
            print(error)
            return nil
        }
    }

    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        guard let url = resource.url else { return }
        load(url, withCompletion: completion)
    }
}
