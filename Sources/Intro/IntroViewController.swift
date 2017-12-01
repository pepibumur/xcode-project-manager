import Foundation
import Cocoa
import RxCocoa

class IntroViewController: NSViewController, IntroViewing, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var leftPanelView: NSView!
    @IBOutlet weak var versionTextField: NSTextField!
    var presenter: IntroViewPresenting!
    override var nibName: NSNib.Name? { return NSNib.Name(rawValue: "IntroViewController") }
    let scrollView: NSScrollView = NSScrollView()
    let tableView: NSTableView = NSTableView()

    // MARK: - Lifeccycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
    
    // MARK: - IntroViewing
    
    func setVersion(_ version: String) {
        self.versionTextField.stringValue = "Version: \(version)"
    }
    
    // MARK: - Private
    
    private func setup() {
        setupFormat()
        setupTableView()
        setupScrollView()
    }

    private func setupFormat() {
        self.leftPanelView.layer?.backgroundColor = NSColor.white.cgColor
    }

    private func setupScrollView() {
        scrollView.focusRingType = .none
        scrollView.backgroundColor = .white
        scrollView.borderType = .noBorder
        scrollView.documentView = self.tableView
        scrollView.hasHorizontalScroller = false
        scrollView.hasVerticalScroller = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leftPanelView.trailingAnchor)
        ])
    }

    private func setupTableView() {
        tableView.focusRingType = .none
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.floatsGroupRows = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.allowsMultipleSelection = false
        tableView.headerView = nil
        tableView.floatsGroupRows = true
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "projects"))
        tableView.addTableColumn(column)
        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: true)
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

    func tableViewSelectionDidChange(_ notification: Notification) {
        print("\(tableView.selectedRow)")
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }

}
