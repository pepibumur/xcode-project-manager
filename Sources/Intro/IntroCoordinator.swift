import Foundation
import Cocoa

class IntroCoordinator: Coordinator {
    
    var introWindowController: IntroWindowController?
    
    func start(element: Void?, completion: (() -> ())?) {
        if introWindowController == nil {
            let viewController = IntroViewController()
            viewController.presenter = IntroViewPresenter(view: viewController)
            let window = NSWindow(contentViewController: viewController)
            introWindowController = IntroWindowController(window: window)
            introWindowController?.presenter = IntroWindowPresenter(window: introWindowController!)
        }
        introWindowController?.showWindow(self)
        completion?()
    }
    
}
