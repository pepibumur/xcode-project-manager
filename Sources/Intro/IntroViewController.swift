import Foundation
import Cocoa
import RxCocoa

class IntroViewController: NSViewController, IntroViewing, NSTableViewDelegate, NSTableViewDataSource {

    // MARK: - Attributes

    let leftView: NSView = NSView()
    var presenter: IntroViewPresenting!
    let scrollView: NSScrollView = NSScrollView()
    let tableView: NSTableView = NSTableView()
    let iconView: NSImageView = NSImageView()
    let titleTextField: NSTextField = NSTextField(labelWithString: "")
    let versionTextField: NSTextField = NSTextField(labelWithString: "")

    // MARK: - Lifeccycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }

    override func loadView() {
        // Otherwise the system will try to load the view from a .xib file by default
        self.view = NSView()
    }

    // MARK: - IntroViewing
    
    func setVersion(_ version: String) {
        versionTextField.stringValue = "Version: \(version)"
    }
    
    // MARK: - Private
    
    private func setup() {
        setupLeftView()
        setupTableView()
        setupScrollView()
    }

    private func setupLeftView() {
        leftView.wantsLayer = true
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.layer?.backgroundColor = NSColor.white.cgColor
        view.addSubview(leftView)
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftView.trailingAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        iconView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(iconView)
        iconView.image = NSImage(named: NSImage.Name(rawValue: "AppIcon"))
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 130),
            iconView.widthAnchor.constraint(equalToConstant: 130),
            iconView.centerXAnchor.constraint(equalTo: leftView.centerXAnchor)
        ])
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(titleTextField)
        titleTextField.stringValue = "Welcome to XcodePM"
        titleTextField.maximumNumberOfLines = 1
        titleTextField.alignment = .center
        titleTextField.font = NSFont.systemFont(ofSize: 30, weight: .thin)
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -20)
        ])
        versionTextField.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(versionTextField)
        versionTextField.maximumNumberOfLines = 1
        versionTextField.alignment = .center
        versionTextField.font = NSFont.systemFont(ofSize: 15, weight: .thin)
        NSLayoutConstraint.activate([
            versionTextField.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            versionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            versionTextField.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            versionTextField.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -20)
        ])
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
            scrollView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor)
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
        tableView.backgroundColor = NSColor(deviceWhite: 0.95, alpha: 1.0)
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
