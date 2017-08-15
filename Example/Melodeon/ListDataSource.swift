//
//  ListDataSource.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import Melodeon

class ListDataSource: MelodeonDataSource {
    
    var firstList = ["Option One", "Option Two", "Option Three"]
    var secondList = ["Choice One", "Choice Two", "Choice Three", "Choice Four" ]
    var thirdList = ["Element One", "Element Two"]
    var fourthList = ["Item One", "Item Two", "Item Three"]
    var fifthList = ["Subject One", "Subject Two"]

    override func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return firstList.count
        case 1:
            return secondList.count
        case 2:
            return thirdList.count
        case 3:
            return fourthList.count
        case 4:
            return fifthList.count
        default:
            return 0
        }
    }

    override var initialExpandedSection: Int {
        return 0
    }

    override func headerHeight(forSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        }
        let scale = (40 * ((CGFloat(section) + 0.30)/2))
        return super.headerHeight(forSection: section) + scale
    }

    override var sections:[Any] {
        return ["List A", "List D", "List B", "List E", "List C"]
    }

    override func title(forIndexPath indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return firstList[indexPath.item]
        case 1:
            return secondList[indexPath.item]
        case 2:
            return thirdList[indexPath.item]
        case 3:
            return fourthList[indexPath.item]
        case 4:
            return fifthList[indexPath.item]
        default:
            return super.title(forIndexPath: indexPath)
        }
    }

    override var headerClasses:[MelodeonHeaderCell.Type]? {
        return [TableHeaderCell.self]
    }


}
