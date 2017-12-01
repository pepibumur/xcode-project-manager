import Foundation
import Cocoa
import macOSThemeKit

class AppCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    var introCoordinator: IntroCoordinator?
    
    // MARK: - Init
    
    init() {}
    
    // MARK: - Coordinator
    
    func start(element: Notification?, completion: (() -> ())? = nil) {
        ThemeManager.lightTheme.apply()
        setupDevMate()
        if introCoordinator == nil {
            introCoordinator = IntroCoordinator()
        }
        introCoordinator?.start(element: nil, completion: completion)
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupDevMate() {
        DevMateKit.sendTrackingReport(nil, delegate: nil)
        DevMateKit.setupIssuesController(nil, reportingUnhandledIssues: true)
    }
    
}
