import Foundation
import Sentry

final class Tools {
    
    static let crashReporter: CrashReporting = Client.makeXpmClient(dsn: Tools.environment.sentryDsn)
    static let environment: Environmenting = Environment()
    static let settingsStorage: KeyValueStoring = KeyValueStorage(name: "settings")
    
}
