import Foundation

// MARK: - StorageProvider

protocol StorageProvider {
    func store(data: Data, forKey key: StorageProviderKey) throws
    func data(forKey key: StorageProviderKey) throws -> Data?
}

// MARK: - StorageProviderKey

enum StorageProviderKey: String {
    case todos
}
