// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Security

final class KeychainService {
    static let instance = KeychainService()
    private init() {}

    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }

    func saveToken(_ token: String, forKey key: String) throws {
        if let data = token.data(using: .utf8) {
            let queryMap: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            let status = SecItemAdd(queryMap as CFDictionary, nil)
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            }
        }
    }

    func getToken(forKey key: String) -> String? {
        let queryMap: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(queryMap as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
