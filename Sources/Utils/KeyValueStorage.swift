import Foundation
import RxSwift

class KeyValueStorage: ReadWriteRepository, ObservableRepository {
    
    // MARK: - Private
    
    private let name: String
    private let userDefaults: UserDefaults
    private var subjects: [String: PublishSubject<RepositoryChange<Any>>] = [:]
    
    // MARK: - Init
    
    init(name: String, userDefaults: UserDefaults = .standard) {
        self.name = name
        self.userDefaults = userDefaults
    }
    
    // MARK: - Fileprivate
    
    private func readDictionary() -> [String: Data] {
        return (userDefaults.value(forKey: name) as? [String: Data]) ?? [:]
    }
    
    private func readData(key: String) -> Data? {
        return readDictionary()[key]
    }
    
    private func writeData(key: String, data: Data) {
        var dictionary = readDictionary()
        dictionary[key] = data
        userDefaults.set(dictionary, forKey: name)
        userDefaults.synchronize()
    }
    
    private func removeData(key: String) {
        var dictionary = readDictionary()
        dictionary.removeValue(forKey: key)
        userDefaults.set(dictionary, forKey: name)
        userDefaults.synchronize()
    }
    
    // MARK: - ObservableRepository
    
    func observe<T>(key: String) -> Observable<RepositoryChange<T>> {
        var subject: PublishSubject<RepositoryChange<T>>! = subjects[key] as! PublishSubject<RepositoryChange<T>>
        if subject == nil {
            subject = PublishSubject()
        }
        return subject.asObserver()
    }
    
    // MARK: - ReadWriteRepository
    
    func write<T>(_ value: T, key: String) throws where T : Decodable, T : Encodable {
        let encoder = JSONEncoder()
        let data = try encoder.encode(value)
        writeData(key: key, data: data)
        subjects[key]?.onNext(.upate(value))
    }
    
    func remove(key: String) {
        removeData(key: key)
        subjects[key]?.onNext(.remove)
    }
    
    func removeAll() {
        userDefaults.removeObject(forKey: name)
        userDefaults.synchronize()
    }
    
    func read<T>(key: String) -> T? where T : Decodable, T : Encodable {
        let decoder  = JSONDecoder()
        return readData(key: key).flatMap({ try? decoder.decode(T.self, from: $0) })
    }
    
}
