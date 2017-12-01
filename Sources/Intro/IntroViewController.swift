import Foundation
import Cocoa

class IntroViewController: NSViewController, IntroViewing, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var leftPanelView: NSView!
    @IBOutlet weak var versionTextField: NSTextField!
    var presenter: IntroViewPresenting!
    override var nibName: NSNib.Name? { return NSNib.Name(rawValue: "IntroViewController") }
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var scrollView: NSScrollView!
    
    // MARK: - Lifeccycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - IntroViewing
    
    func setVersion(_ version: String) {
        self.versionTextField.stringValue = "Version: \(version)"
    }
    
    // MARK: - Private
    
    private func setup() {
        setupFormat()
        setupTableView()
    }
    
    private func setupFormat() {
        self.leftPanelView.layer?.backgroundColor = NSColor.white.cgColor
        self.scrollView.layer?.backgroundColor = NSColor.red.cgColor
    }
    
    private func setupTableView() {
        tableView.focusRingType = .none
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.floatsGroupRows = true
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "Projects")
        var rowView = tableView.makeView(withIdentifier: identifier, owner: tableView) as? IntroRowView
        if rowView == nil {
            rowView = IntroRowView(frame: .zero)
            rowView?.identifier = identifier
        }
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "Projects")
        var cellView = tableView.makeView(withIdentifier: identifier, owner: tableView) as? IntroCellView
        if cellView == nil {
            cellView = IntroCellView()
            cellView?.identifier = identifier
        }
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
    
}
