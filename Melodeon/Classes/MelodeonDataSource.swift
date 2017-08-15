//
//  MelodeonDataSource.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit

open class MelodeonDataSource: NSObject {

    // An array reference to sections current state (collapsed is true, expanded is false).
    private var sectionIsCollapsed:[Bool] = []

    override public init() {
        super.init()
        self.loadDefaultState()
    }

    // Set all state to collapse, set all to true.
    // If the initial expanded section is defined we set it to false.
    private func loadDefaultState() {
        for index in 0..<sections.count {
            if index == self.initialExpandedSection {
                sectionIsCollapsed.append(false)
            } else {
                sectionIsCollapsed.append(true)
            }
        }
    }

    // Override to provide the index of the section you want to be expanded by default.
    open var initialExpandedSection:Int {
        return -1
    }

    // Override to provide the section's labels and to get the total number of sections.
    open var sections:[Any] {
        return []
    }

    // Override to return the header classes you want to use here.
    open var headerClasses:[MelodeonHeaderCell.Type]? {
        return []
    }

    // Override to supply the header height of a specific section.
    // Default is 44.0 from MelodeonHeaderCell.defaultHeight
    open func headerHeight(forSection section: Int) -> CGFloat {
        return MelodeonHeaderCell.defaultHeight
    }

    // Override to provide the title of each cells if you're using the default UITableViewCell class.
    open func title(forIndexPath indexPath: IndexPath) -> String {
        return "Cell \(indexPath.row)"
    }

    // Override to give the total number of rows for each section.
    open func numberOfRowsInSection(_ section:Int) -> Int {
        return 0
    }

    // Convenience property that returns which section is currently expanded. (Internal use only)
    var expandedSection:Int? {
        guard let index = sectionIsCollapsed.index(where: { $0 == false }) else {
            return nil
        }
        return index
    }

    // Get the status of a specific section. (Internal use only)
    func section(collapsedFor section: Int) -> Bool {
        return sectionIsCollapsed[section]
    }

    // Set the collapse status of given section. (Internal use only)
    func toggleCollapse(forSection section: Int, collapsed:Bool) {
        sectionIsCollapsed[section] = collapsed
    }
}
