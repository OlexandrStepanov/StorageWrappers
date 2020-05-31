import Foundation


@propertyWrapper struct StoredData<StorageType: Storage> {
    private let key: String
    private let storage: StorageType

    init(key: String, storage: StorageType) {
        self.key = key
        self.storage = storage
    }

    var wrappedValue: Data? {
        get {
            return storage.storedData(with: key)
        }
        set {
            if let newValue = newValue {
                storage.store(data: newValue, with: key)
            } else {
                storage.eraseData(with: key)
            }
        }
    }
}

@propertyWrapper struct StoredString<StorageType: Storage> {
    private let key: String
    private let storage: StorageType

    init(key: String, storage: StorageType) {
        self.key = key
        self.storage = storage
    }

    var wrappedValue: String? {
        get {
            return storedString(with: key)
        }
        set {
            if let newValue = newValue {
                persist(string: newValue, with: key)
            } else {
                storage.eraseData(with: key)
            }
        }
    }

    private func storedString(with key: String) -> String? {
        var result: String?
        if let data = storage.storedData(with: key) {
            result = String.init(data: data, encoding: .utf8)
        }
        return result
    }

    private func persist(string: String, with key: String) {
        if let data = string.data(using: .utf8) {
            storage.store(data: data, with: key)
        } else {
            print("Can't encode to UTF8 data string: \(string)")
        }
    }
}

@propertyWrapper struct StoredCodable<T: Codable, StorageType: Storage> {
    private let key: String
    private let storage: StorageType

    init(key: String, storage: StorageType) {
        self.key = key
        self.storage = storage
    }

    var wrappedValue: T? {
        get {
            return storedValue(with: key)
        }
        set {
            if let newValue = newValue {
                store(value: newValue, with: key)
            } else {
                storage.eraseData(with: key)
            }
        }
    }
    
    private func storedValue<T: Codable>(with key: String) -> T? {
        var result: T?
        do {
            let data = storage.storedData(with: key)
            if let data = data {
                result = try JSONDecoder().decode(T.self, from: data)
            }
        } catch {
            print("Can't parse object by key=\(key) from keychain: \(error.localizedDescription)")
        }
        return result
    }

    private func store<T: Codable>(value: T, with key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            storage.store(data: data, with: key)
        } catch {
            print("Can't encode object by key=\(key) in keychain: \(error.localizedDescription)")
        }
    }
}
