import Foundation

protocol Environmenting {
    func value<T>(key: String) -> T
    var sentryDsn: String { get }
}

final class Environment: Environmenting {
    
    private static var dictionay: [String: Any]!
    
    // MARK: - Internal
    
    func value<T>(key: String) -> T {
        if Environment.dictionay == nil {
            Environment.dictionay = Environment.readPlist()
        }
        return Environment.dictionay[key] as! T
    }
    
    // MARK: - Fileprivate
    
    fileprivate static func readPlist() -> [String: Any] {
        var plistName: String!
        #if DEBUG
            plistName = "Environment-Debug"
        #else
            plistName = "Environment-Release"
        #endif
        let url = Bundle.main.path(forResource: "Config", ofType: "plist")!
        return NSDictionary(contentsOfFile: url) as! [String : Any]
    }
    
}

extension Environment {
    
    var sentryDsn: String {
        return value(key: "sentry_dsn")
    }
    
}
