import Foundation

open class DefaultsKeys {
    fileprivate init() {}
}

open class DefaultsKey<ValueType>: DefaultsKeys {
    public let _key: String
    
    public init(_ key: String) {
        self._key = key
        super.init()
    }
}

extension UserDefaults {
    
    public subscript<T: Codable>(key: DefaultsKey<T>) -> T? {
        get {
            guard let data = object(forKey: key._key) as? Data else { return nil }
            
            let decoder = JSONDecoder()
            let dictionary = try! decoder.decode([String: T].self, from: data)
            return dictionary["top"]
        }
        set {
            guard let value = newValue else { return set(nil, forKey: key._key) }
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(["top": value])
            set(data, forKey: key._key)
        }
    }
}


//// Usage
//extension DefaultsKeys {
//    static let accessToken = DefaultsKey<AccessToken>("access_token")
//}
//
//guard let token = Defaults[.accessToken] else { return }

