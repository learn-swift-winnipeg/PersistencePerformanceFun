import Disk

// MARK: - DiskFrameworkStorageProvider

class DiskFrameworkStorageProvider: StorageProvider {
    func store(data: Data, forKey key: StorageProviderKey) throws {
        try Disk.save(data, to: .documents, as: key.rawValue)
    }
    
    func data(forKey key: StorageProviderKey) throws -> Data? {
        return try Disk.retrieve(key.rawValue, from: .documents, as: Data.self)
    }
}
