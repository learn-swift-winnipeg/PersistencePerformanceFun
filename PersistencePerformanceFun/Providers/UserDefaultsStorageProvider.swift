import Foundation

// MARK: - UserDefaultsStorageProvider

class UserDefaultsStorageProvider: StorageProvider {
    
    // MARK: - Stored Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - StorageProvider
    
    func store(data: Data, forKey key: StorageProviderKey) throws {
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func data(forKey key: StorageProviderKey) throws -> Data? {
        return userDefaults.data(forKey: key.rawValue)
    }
}
