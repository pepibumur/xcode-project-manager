import Foundation
import Cocoa

class IntroViewController: NSViewController, IntroViewing {
    
    @IBOutlet weak var leftPanelView: NSView!
    @IBOutlet weak var versionTextField: NSTextField!
    var presenter: IntroViewPresenting!
    
    // MARK: - Lifeccycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFormat()
    }
    
    // MARK: - Private
    
    private func setupFormat() {
        self.leftPanelView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
}
