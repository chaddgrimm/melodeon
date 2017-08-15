//
//  MelodeonDataSource.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit

open class MelodeonDataSource: NSObject {

    private var sectionIsCollapsed:[Bool] = []

    override public init() {
        super.init()
        self.loadDefaultState()
    }

    private func loadDefaultState() {
        for index in 0..<sections.count {
            if index == self.initialExpandedSection {
                sectionIsCollapsed.append(false)
            } else {
                sectionIsCollapsed.append(true)
            }
        }
    }

    open var initialExpandedSection:Int {
        return -1
    }

    open var sections:[Any] {
        return []
    }

    // Return header classes you'll use here
    open var headerClasses:[MelodeonHeaderCell.Type]? {
        return []
    }

    open func headerHeight(forSection section: Int) -> CGFloat {
        return MelodeonHeaderCell.defaultHeight
    }

    open func title(forIndexPath indexPath: IndexPath) -> String {
        return "Cell \(indexPath.row)"
    }

    open func numberOfRowsInSection(_ section:Int) -> Int {
        return 0
    }

    public var expandedSection:Int? {
        guard let index = sectionIsCollapsed.index(where: { $0 == false }) else {
            return nil
        }
        return index
    }

    func section(collapsedFor section: Int) -> Bool {
        return sectionIsCollapsed[section]
    }

    func toggleCollapse(forSection section: Int, collapsed:Bool) {
        sectionIsCollapsed[section] = collapsed
    }
}
