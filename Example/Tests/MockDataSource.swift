//
//  MockDataSource.swift
//  Melodeon
//
//  Created by Frederick Lee on 15/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Melodeon

class MockDataSource:MelodeonDataSource {
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

    public override var sections:[Any] {
        return ["List A", "List B", "List C", "List D", "List E"]
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

}
