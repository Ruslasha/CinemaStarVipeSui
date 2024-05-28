// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    public func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var urlRequest = URLRequest(url: url)
//        urlRequest.setValue("WQT8GHV-ZYH45ES-PE33B08-KNRNHJ2", forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue(KeychainService.instance.getToken(forKey: "TokenKP"), forHTTPHeaderField: "X-API-KEY")
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
