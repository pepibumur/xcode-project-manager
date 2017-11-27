import Foundation
import Sparkle
import Cocoa
import macOSThemeKit

class AppCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    let updater: SUUpdater
    var introCoordinator: IntroCoordinator?
    
    // MARK: - Init
    
    init(updater: SUUpdater = SUUpdater(for: nil)) {
        self.updater = updater
    }
    
    func start(element: Notification?, completion: (() -> ())? = nil) {
        ThemeManager.lightTheme.apply()
        if introCoordinator == nil {
            introCoordinator = IntroCoordinator()
        }
        introCoordinator?.start(element: nil, completion: completion)
    }
    
}
