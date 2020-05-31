//
//  File.swift
//  
//
//  Created by Oleksandr Stepanov on 31.05.2020.
//

import Foundation
import KeychainAccess

final class KeychainStorage: Storage {
    static let sharedInstance: KeychainStorage = .init()
    
    private let keychain = Keychain()
    private let accessibility: Accessibility = .whenUnlockedThisDeviceOnly
    
    func storedData(with key: String) -> Data? {
        do {
            return try keychain.getData(key)
        } catch {
            print("Can't read data by key=\(key) from keychain: \(error.localizedDescription)")
        }
        return nil
    }
    
    func store(data: Data, with key: String) {
        do {
            try keychain.accessibility(accessibility).set(data, key: key)
        } catch {
            print("Can't store data by key=\(key) in keychain: \(error.localizedDescription)")
        }
    }
    
    func eraseData(with key: String) {
        do {
            try keychain.remove(key)
        } catch {
            print("Can't remove object by key=\(key) from keychain: \(error.localizedDescription)")
        }
    }
}
