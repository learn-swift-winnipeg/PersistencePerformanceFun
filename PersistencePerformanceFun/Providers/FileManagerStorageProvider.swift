import Foundation

// MARK: - FileManagerStorageProvider

class FileManagerStorageProvider: StorageProvider {
    
    // MARK: - Stored Properties
    
    private let fileManager = FileManager.default
    
    // MARK: - StorageProvider
    
    func store(data: Data, forKey key: StorageProviderKey) throws {
        let url = self.url(forKey: key)
        try data.write(to: url, options: .atomic)
    }
    
    func data(forKey key: StorageProviderKey) throws -> Data? {
        let url = self.url(forKey: key)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        return try Data(contentsOf: url)
    }
    
    // MARK: - Path/URL
    
    private func url(forKey key: StorageProviderKey) -> URL {
        return documentDirectoryURL.appendingPathComponent(key.rawValue)
    }
    
    private var documentDirectoryURL: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
