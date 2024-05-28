// ImageRequest.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// 1
class ImageRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        UIImage(data: data)
    }

    func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url: url, withCompletion: completion)
    }

    func load(url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}
