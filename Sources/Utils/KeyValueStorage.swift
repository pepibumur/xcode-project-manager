import Foundation
import RxSwift

class KeyValueStorage {
    
    enum Change<T> {
        case update(T)
        case remove
        var value: T? {
            switch self {
            case .update(let value): return value
            case .remove: return nil
            }
        }
    }
    
    // MARK: - Private
    
    private let name: String
    private let userDefaults: UserDefaults
    private var subjects: [String: Any] = [:]
    
    // MARK: - Init
    
    init(name: String, userDefaults: UserDefaults = .standard) {
        self.name = name
        self.userDefaults = userDefaults
    }
    
    // MARK : - Internal
    
    func observe<T>(key: String) -> Observable<Change<T>> {
        var subject: PublishSubject<Change<T>>!
        if let _subject = subjects[key] {
            subject = _subject as? PublishSubject<Change<T>>
        }
        if subject == nil {
            subject = PublishSubject<Change<T>>()
            subjects[key] = subject
        }
        return subject.asObserver()
    }
    
    func write<T>(_ value: T, key: String) throws where T : Encodable {
        if isJSONCodable(type: T.self) {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            writeData(key: key, data: data)
        } else {
            writeValue(key: key, value: value)
        }
        (subjects[key] as? PublishSubject<Change<T>>)?.onNext(.update(value))
    }
    
    func remove(key: String) {
        removeData(key: key)
        let subject = subjects[key]
        (subject as? PublishSubject<Change<Any>>)?.onNext(.remove)
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
