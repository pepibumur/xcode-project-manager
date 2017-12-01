import Foundation
import Cocoa

class IntroWindowController: NSWindowController, NSWindowDelegate, IntroWindowing {

    // MARK: - Constants
    
    static let defaultSize = NSSize(width: 800, height: 500)
    
    // MARK: - Attributes
    
    var presenter: IntroWindowPresenting!
    
    // MARK: - Internal

    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        window?.center()
        window?.animator().alphaValue = 1.0
        var frame = self.window?.frame ?? CGRect.zero
        frame.size = IntroWindowController.defaultSize
        self.window?.setFrame(frame, display: true)
        window?.collectionBehavior = [NSWindow.CollectionBehavior.transient, NSWindow.CollectionBehavior.ignoresCycle]
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.delegate = self
    }
    
    // MARK: - IntroWindowing


    // MARK: - NSWindowDelegate
    
    public func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        return IntroWindowController.defaultSize
    }
    
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains(.command) {
            switch event.charactersIgnoringModifiers! {
            case "w":
                self.window?.close()
            default:
                break
            }
        }
    }
}
