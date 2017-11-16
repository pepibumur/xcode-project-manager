import Foundation

protocol ReadRepository {
    func read<T: Codable>(key: String) -> T?
}

protocol WriteRepository {
    func write<T: Codable>(_ value: T, key: String) throws
    func remove(key: String)
}

protocol ReadWriteRepository: WriteRepository, ReadRepository {}

// MARK: - UserDefaults Extension (ReadWriteRepository)

extension UserDefaults: ReadWriteRepository {
    
    func read<T>(key: String) -> T? where T : Decodable, T : Encodable {
        
    }
    
    func write<T>(_ value: T, key: String) throws where T : Decodable, T : Encodable {
        
    }
    
    func remove(key: String) {
        self.removeObject(forKey: key)
        self.synchronize()
    }
    
}
