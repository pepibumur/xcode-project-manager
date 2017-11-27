import Foundation
import Sentry

enum CrashEventSeverity {
    case fatal
    case error
    case warning
    case info
    case debug
}

fileprivate extension CrashEventSeverity {
    var sentrySeverity: SentrySeverity {
        switch self {
        case .debug: return .debug
        case .error: return .error
        case .fatal: return .fatal
        case .info: return .info
        case .warning: return .warning
        }
    }
}

protocol CrashReporting {
    func send(error: Error,
              severity: CrashEventSeverity,
              message: String)
    func sendEvent(message: String,
                   severity: CrashEventSeverity,
                   extra: [String: Any]?)
}

extension Client {
    static func makeXpmClient(dsn: String) -> Client {
        // TODO: Symbols need to be uploaded to desymbolicate the crashes.
        let client = try! Client(dsn: dsn)
        try! client.startCrashHandler()
        client.enableAutomaticBreadcrumbTracking()
        Client.shared = client
        return client
    }
}

extension Client: CrashReporting {
    
    func sendEvent(message: String,
                   severity: CrashEventSeverity,
                   extra: [String: Any]? = nil) {
        let event = Event(level: severity.sentrySeverity)
        event.extra = extra
        self.send(event: event, completion: nil)
    }

    func send(error: Error,
              severity: CrashEventSeverity,
              message: String) {
        var extra: [String: Any] = [:]
        extra["error"] = error.localizedDescription
        sendEvent(message: message,
                  severity: severity,
                  extra: extra)
    }
    
}
