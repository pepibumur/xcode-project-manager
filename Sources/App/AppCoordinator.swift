import Foundation
import Sparkle
import Cocoa
import macOSThemeKit

class AppCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    let updater: SUUpdater
    var introWindowController: IntroWindowController?
    
    // MARK: - Init
    
    init(updater: SUUpdater = SUUpdater(for: nil)) {
        self.updater = updater
    }
    
    func start(element: Notification?, completion: (() -> ())? = nil) {
        ThemeManager.lightTheme.apply()
        if introWindowController == nil {
            introWindowController = IntroWindowController()
        }
        introWindowController?.showWindow(self)
        completion?()
    }
    
}
