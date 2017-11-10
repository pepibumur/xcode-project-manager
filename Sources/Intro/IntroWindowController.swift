import Foundation
import Cocoa

class IntroWindowController: NSWindowController, NSWindowDelegate {

    // MARK: - Constants
    
    static let defaultSize = NSSize(width: 800, height: 500)
    
    // MARK: - Init
    
    convenience init() {
        self.init(windowNibName: NSNib.Name.init("IntroWindowController"))
    }

    override func showWindow(_ sender: Any?) {
        window?.center()
        window?.alphaValue = 0.0
        super.showWindow(sender)
        window?.animator().alphaValue = 1.0
        var frame = self.window?.frame ?? CGRect.zero
        frame.size = IntroWindowController.defaultSize
        self.window?.setFrame(frame, display: true)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.collectionBehavior = [NSWindow.CollectionBehavior.transient, NSWindow.CollectionBehavior.ignoresCycle]
        window?.isMovableByWindowBackground = true
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
    }
    
    // MARK: - NSWindowDelegate
    
    public func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        return IntroWindowController.defaultSize
    }
    
}
