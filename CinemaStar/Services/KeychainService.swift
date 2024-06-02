// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainAccess


final class KeychainManager {

    static let shared = KeychainManager()
    private let keychain = Keychain(service: "ruslan.CinemaStar")

    private init() {}

    func saveToken(_ key: String) {
        keychain["token"] = key
    }

    func loadToken() -> String? {
        return keychain["token"]
    }
}
