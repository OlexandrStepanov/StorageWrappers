//
//  DefaultsStorage.swift
//  
//
//  Created by Oleksandr Stepanov on 31.05.2020.
//

import Foundation

final class DefaultsStorage: Storage {
    static let sharedInstance: DefaultsStorage = .init()
    
    private let defaults = UserDefaults.standard
    
    func storedData(with key: String) -> Data? {
        return defaults.data(forKey: key)
    }
    
    func store(data: Data, with key: String) {
        defaults.set(data, forKey: key)
    }
    
    func eraseData(with key: String) {
        defaults.removeObject(forKey: key)
    }
}
