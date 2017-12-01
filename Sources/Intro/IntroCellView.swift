import Foundation
import Cocoa

class IntroCellView: NSTableCellView {

    // MARK: - Attributes

    let centerView: NSView = NSView()
    let titleTextView: NSTextField = NSTextField(labelWithString: "")
    let detailTextView: NSTextField = NSTextField(labelWithString: "")
    let iconImageView: NSImageView = NSImageView()


    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    // MARK: - Fileprivate

    fileprivate func setup() {
        setupLayout()
        setupContent()
    }

    fileprivate func setupContent() {
        titleTextView.stringValue = "Project"
        detailTextView.stringValue = "Path"
        iconImageView.wantsLayer = true
        iconImageView.layer?.backgroundColor = NSColor.red.cgColor
        detailTextView.backgroundColor = .blue
    }

    fileprivate func setupLayout() {
        centerView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerView)
        centerView.addSubview(titleTextView)
        centerView.addSubview(detailTextView)
        centerView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            centerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            iconImageView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 10),
            iconImageView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor, constant: -10),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            titleTextView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleTextView.centerYAnchor.constraint(equalTo: centerView.centerYAnchor, constant: -10),
            titleTextView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -10),
            detailTextView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            detailTextView.centerYAnchor.constraint(equalTo: centerView.centerYAnchor, constant: 10),
            detailTextView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -10),
        ])
    }

}
