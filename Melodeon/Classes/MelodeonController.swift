//
//  MelodeonController.swift
//  Melodeon
//
//  Created by Chad Lee on 09/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit

open class MelodeonController: UITableViewController {

    // Register all header classes whenever a datasource instanced is assigned
    // This will then reload the table view
    open var dataSource: MelodeonDataSource? {
        didSet {
            if let headerClasses = dataSource?.headerClasses {
                for headerClass in headerClasses {
                    tableView?.register(headerClass, forHeaderFooterViewReuseIdentifier: NSStringFromClass(headerClass))
                }
            }
            tableView.reloadData()
        }
    }

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

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Register our default Header
        tableView.register(MelodeonHeaderCell.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(MelodeonHeaderCell.self))
    }

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.sections.count ?? 0
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.section(collapsedFor: section) ? 0 : dataSource.numberOfRowsInSection(section)
    }

    override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = self.dataSource else {
            return nil
        }
        let reusableView: MelodeonHeaderCell
        if let classes = dataSource.headerClasses, classes.count > section {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(classes[section])) as! MelodeonHeaderCell
        } else if let cls = dataSource.headerClasses?.first {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(cls)) as! MelodeonHeaderCell
        } else {
            reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(MelodeonHeaderCell.self)) as! MelodeonHeaderCell
        }
        reusableView.item = dataSource.sections[section]
        reusableView.collapsed = dataSource.section(collapsedFor: section)
        reusableView.isInteractive = true
        reusableView.section = section
        reusableView.headerTapped = { [weak self] section in self?.headerTapped(section) }
        return reusableView
    }

    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let height:CGFloat = dataSource?.headerHeight(forSection: section) else {
            return MelodeonHeaderCell.defaultHeight
        }
        return height
    }

    // Default implimentation of cell views, this can be overriden if you want to supply your custom cells just like you would on a non-subclassed UITableViewController
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(NSStringFromClass(MelodeonController.self)).Cell"
        let title = dataSource?.title(forIndexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell.textLabel?.text = title
            return cell
        }
        cell.textLabel?.text = title
        return cell
    }

    // Check whether you want to expand or collapse the header whenever it is tapped.
    private func headerTapped(_ section:Int) {
        guard let dataSource = self.dataSource else {
            return
        }

        var expanded = section
        let selected = section

        // Checks if there's an expanded section.
        if let index = dataSource.expandedSection {
            expanded = index
        }

        // Expand the selected section, this will also check if the section is already open.
        // If so, it will close that same section.
        self.expand(section: selected)

        // Collapse or close any expanded sections, if it isn't the same as the selected section.
        if expanded != selected {
            self.collapse(section: expanded)
        }

    }

    private func collapse(section:Int) {
        guard let sectionView = self.tableView.headerView(forSection: section) as? MelodeonHeaderCell, let dataSource = self.dataSource else {
            return
        }
        let count = dataSource.numberOfRowsInSection(section)
        let indexPaths:[IndexPath] = (0..<count).map { IndexPath(row: $0, section: section) }
        OperationQueue.main.addOperation { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: indexPaths, with: .none)
            dataSource.toggleCollapse(forSection: section, collapsed: true)
            sectionView.collapsed = true
            self?.tableView.endUpdates()
        }
    }

    private func expand(section:Int) {
        guard let sectionView = self.tableView.headerView(forSection: section) as? MelodeonHeaderCell, let dataSource = self.dataSource else {
            return
        }
        let count = dataSource.numberOfRowsInSection(section)
        let sectionIsCollapsed = sectionView.isCollapsed
        let indexPaths:[IndexPath] = (0..<count).map { IndexPath(row: $0, section: section)}
        OperationQueue.main.addOperation { [weak self] in
            self?.tableView.beginUpdates()
            sectionView.collapsed = !sectionIsCollapsed
            if sectionIsCollapsed {
                self?.tableView.insertRows(at: indexPaths, with: .none)
            } else {
                self?.tableView.deleteRows(at: indexPaths, with: .none)
            }
            dataSource.toggleCollapse(forSection: section, collapsed: !sectionIsCollapsed)
            self?.tableView.endUpdates()
        }
    }
}
