import Foundation
import RxSwift

protocol KeyValueStoring {
    func observe<T>(key: String) -> Observable<T?>
    func write<T>(_ value: T, key: String) throws where T : Encodable
    func remove(key: String)
    func removeAll()
    func read<T>(key: String) -> T? where T : Decodable
}

class KeyValueStorage: KeyValueStoring {
    
    // MARK: - Private
    
    private let name: String
    private let userDefaults: UserDefaults
    private var subjects: [String: PublishSubject<Any?>] = [:]
    
    // MARK: - Init
    
    init(name: String, userDefaults: UserDefaults = .standard) {
        self.name = name
        self.userDefaults = userDefaults
    }
    
    // MARK : - Internal
    
    func observe<T>(key: String) -> Observable<T?> {
        var subject: PublishSubject<Any?>! = subjects[key]
        if subject == nil {
            subject = PublishSubject<Any?>()
            subjects[key] = subject
        }
        return subject.map({ $0.map({$0 as! T}) })
    }
    
    func write<T>(_ value: T, key: String) throws where T : Encodable {
        if isJSONCodable(type: T.self) {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            writeData(key: key, data: data)
        } else {
            writeValue(key: key, value: value)
        }
        (subjects[key])?.onNext(value)
    }
    
    func remove(key: String) {
        removeData(key: key)
        let subject = subjects[key]
        (subject)?.onNext(nil)
    }
    
    func removeAll() {
        userDefaults.removeObject(forKey: name)
        userDefaults.synchronize()
    }
    
    func read<T>(key: String) -> T? where T : Decodable {
        if isJSONCodable(type: T.self) {
            let decoder  = JSONDecoder()
            return readData(key: key).flatMap({ try? decoder.decode(T.self, from: $0) })
        } else {
            return readValue(key: key) as? T
        }
    }
    
    // MARK: - Private
    
    private func isJSONCodable<T>(type: T.Type) -> Bool {
        return type != Bool.self &&
            type != String.self &&
            type != Int.self &&
            type != UInt.self &&
            type != Float.self &&
            type != Double.self
    }
    
    private func readDictionary() -> [String: Any] {
        return (userDefaults.value(forKey: name) as? [String: Any]) ?? [:]
    }
    
    private func readData(key: String) -> Data? {
        return readDictionary()[key] as? Data
    }
    
    private func readValue(key: String) -> Any? {
        return readDictionary()[key]
    }
    
    private func writeData(key: String, data: Data) {
        var dictionary = readDictionary()
        dictionary[key] = data
        userDefaults.set(dictionary, forKey: name)
        userDefaults.synchronize()
    }
    
    private func writeValue(key: String, value: Any) {
        var dictionary = readDictionary()
        dictionary[key] = value
        userDefaults.set(dictionary, forKey: name)
        userDefaults.synchronize()
    }
    
    private func removeData(key: String) {
        var dictionary = readDictionary()
        dictionary.removeValue(forKey: key)
        userDefaults.set(dictionary, forKey: name)
        userDefaults.synchronize()
    }
    
}
