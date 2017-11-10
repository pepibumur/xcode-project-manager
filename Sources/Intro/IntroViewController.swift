import Foundation
import Cocoa

class IntroViewController: NSViewController {
    
    @IBOutlet weak var leftPanelView: NSView!
    
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
