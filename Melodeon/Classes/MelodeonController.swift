//
//  MelodeonController.swift
//  Melodeon
//
//  Created by Chad Lee on 09/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit

// An internal protocol specifically used by MelodeonController
protocol MelodeonDelegate: class {
    func header(_ header:MelodeonHeaderCell, shouldTapAtSection section: Int) -> Bool
    func header(_ header:MelodeonHeaderCell, didTapAtSection section:Int)
    func header(_ header:MelodeonHeaderCell, forSection section:Int)
}

open class MelodeonController: UITableViewController, MelodeonDelegate {

    // An array reference to sections current state (collapsed is true, expanded is false).
    private var sectionIsCollapsed:[Bool] = []

    // Override to return the header classes you want to use here.
    open var headerClasses:[MelodeonHeaderCell.Type]? {
        return []
    }

    // Override to provide the section's labels and to get the total number of sections.
    open var sections:[Any] {
        return []
    }

    // Override to provide the index of the section you want to be expanded by default.
    open var initialExpandedSection:Int {
        return -1
    }

    private weak var delegate:MelodeonDelegate?


    // Set to true if you want to hide the excess separators on empty cells.
    open var removeTrailingCells:Bool = false {
        willSet {
            if newValue {
                tableView.tableFooterView = UIView()
            } else {
                tableView.tableFooterView = nil
            }
        }
    }

    private func registerClasses() {
        if self.initialExpandedSection > -1 && self.initialExpandedSection < self.sections.count {
            self.toggleCollapse(forSection:self.initialExpandedSection, collapsed:false)
        }

        if let headerClasses = self.headerClasses {
            for headerClass in headerClasses {
                tableView?.register(headerClass, forHeaderFooterViewReuseIdentifier: NSStringFromClass(headerClass))
            }
        }
        tableView.reloadData()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<sections.count {
            sectionIsCollapsed.append(true)
        }
        self.delegate = self
        // Register our the default Header
        self.registerClasses()
        //tableView.register(MelodeonHeaderCell.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(MelodeonHeaderCell.self))



    }

    final override public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count ?? 0
    }

    // Do not override use numberOfRows(inSection:) instead
    final override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(collapsedFor: section) ? 0 : self.numberOfRows(inSection:section)
    }

    // Override to provide the title of each cells if you're using the default UITableViewCell class.
    // else, you can just use the default tableView(tableView:cellForRowAt:)
    open func cellTitle(forIndexPath indexPath: IndexPath) -> String {
        return "Cell \(indexPath.row)"
    }

    // Override to provide the number of rows for each section.
    open func numberOfRows(inSection section:Int) -> Int {
        fatalError("Override to provide the total number of rows per section")
        return 0
    }

    final override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let reusableView: MelodeonHeaderCell
        if let classes = self.headerClasses, classes.count > section {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(classes[section])) as! MelodeonHeaderCell
        } else if let cls = self.headerClasses?.first {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(cls)) as! MelodeonHeaderCell
        } else {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(MelodeonHeaderCell.self)) as! MelodeonHeaderCell
        }
        reusableView.item = self.sections[section]
        reusableView.collapsed = self.section(collapsedFor: section)
        reusableView.isInteractive = true
        reusableView.section = section
        reusableView.headerTapped = { [weak self] section in self?.headerTapped(section) }
        delegate?.header(reusableView, forSection:section)
        return reusableView
    }

    // Override to supply the header height of a specific section.
    // Default is 44.0 from MelodeonHeaderCell.defaultHeight
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MelodeonHeaderCell.defaultHeight
    }

    // Default implimentation of cell views, this can be overriden if you want to supply your custom cells just like you would on a non-subclassed UITableViewController
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(NSStringFromClass(MelodeonController.self)).Cell"
        let title = self.cellTitle(forIndexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell.textLabel?.text = title
            return cell
        }
        cell.textLabel?.text = title
        return cell
    }

    // Override here for tapped at section event.
    open func header(_ header:MelodeonHeaderCell, didTapAtSection section:Int) {

    }

    // Override to get a reference of the headerview of a section
    open func header(_ header:MelodeonHeaderCell, forSection section: Int) {

    }

    // Override if you want a specific section to respond to a tap event (default is true)
    open func header(_ header:MelodeonHeaderCell, shouldTapAtSection section: Int) -> Bool {
        return true
    }

    // Check whether you want to expand or collapse the header whenever it is tapped.
    private func headerTapped(_ section:Int) {
        guard let sectionHeader = self.tableView.headerView(forSection: section) as? MelodeonHeaderCell else {
            return
        }

        // Do nothing if this section doesn't respond to a tap.
        if !self.header(sectionHeader, shouldTapAtSection:section) {
            return
        }

        var expanded = section
        let selected = section

        // Checks if there's an expanded section.
        if let index = self.expandedSection {
            expanded = index
        }


        // Expand the selected section, this will also check if the section is already open.
        // If so, it will close that same section.
        self.toggleHeader(section: selected) { [weak self] in
            self?.delegate?.header(sectionHeader, didTapAtSection:selected)
        }

        // Collapse or close any expanded sections, if it isn't the same as the selected section.
        if expanded != selected {
            self.toggleHeader(section: expanded)
        }


    }

    // Decides if the section should be collapsed or expanded
    private func toggleHeader(section:Int, completion:(()->())? = nil) {
        guard let sectionHeader = self.tableView.headerView(forSection: section) as? MelodeonHeaderCell else {
            return
        }

        // Do nothing if this section doesn't respond to a tap.
        if !self.header(sectionHeader, shouldTapAtSection:section) {
            return
        }

        let count = self.numberOfRows(inSection:section)
        let sectionIsCollapsed = sectionHeader.isCollapsed
        let indexPaths:[IndexPath] = (0..<count).map { IndexPath(row: $0, section: section)}
        OperationQueue.main.addOperation { [weak self] in
            self?.tableView.beginUpdates()
            sectionHeader.collapsed = !sectionIsCollapsed
            // I could've used reloadSections here but I noticed there's some sort
            // of flickering with its animation.
            if sectionIsCollapsed {
                self?.tableView.insertRows(at: indexPaths, with: .automatic)
            } else {
                self?.tableView.deleteRows(at: indexPaths, with: .automatic)
            }
            self?.toggleCollapse(forSection: section, collapsed: !sectionIsCollapsed)
            self?.tableView.endUpdates()
            completion?()
        }
    }


    // Convenience property that returns which section is currently expanded. (Internal use only)
    private var expandedSection:Int? {
        guard let index = sectionIsCollapsed.index(where: { $0 == false }) else {
            return nil
        }
        return index
    }

    // Get the status of a specific section. (Internal use only)
    private func section(collapsedFor section: Int) -> Bool {
        return sectionIsCollapsed[section]
    }

    // Set the collapse status of given section. (Internal use only)
    private func toggleCollapse(forSection section: Int, collapsed:Bool) {
        sectionIsCollapsed[section] = collapsed
    }

}
