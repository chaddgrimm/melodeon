//
//  TableViewController.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import Melodeon

class TableViewController: MelodeonController {

    var firstList = ["Option One", "Option Two", "Option Three"]
    var secondList = ["Choice One", "Choice Two", "Choice Three", "Choice Four" ]
    var thirdList = ["Element One", "Element Two"]
    var fourthList = ["Item One", "Item Two", "Item Three"]
    var fifthList = ["Subject One", "Subject Two"]


    let colors:[UIColor] = [UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1.0),
                            UIColor(red: 253/255, green: 179/255, blue: 37/255, alpha: 1.0),
                            UIColor(red: 251/255, green: 70/255, blue: 70/255, alpha: 1.0),
                            UIColor(red: 76/255, green: 177/255, blue: 210/255, alpha: 1.0),
                            UIColor(red: 253/255, green: 179/255, blue: 235/255, alpha: 1.0)]

    override var sections:[Any] {
        return ["List A", "List B", "List C", "List D", "List E"]
    }

    override var headerClasses:[MelodeonHeaderCell.Type]? {
        return [TableHeaderCell.self]
    }

    override var initialExpandedSection: Int {
        return 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeTrailingCells = true

    }

    override func numberOfRows(inSection section:Int) -> Int {
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

    override func header(_ header: MelodeonHeaderCell, shouldTapAtSection section: Int) -> Bool {
        // Disable tap event on the third section
        if section == 2 {
            return false
        }
        return true
    }

    override func header(_ header: MelodeonHeaderCell, didTapAtSection section: Int) {
        print("Header at section \(section) \(header.isCollapsed ? "is collapsed" : "is expanded").")
    }

    override func cellTitle(forIndexPath indexPath: IndexPath) -> String {
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
            return super.cellTitle(forIndexPath: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .white
            view.contentView.backgroundColor = colors[section]
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colors[indexPath.section].withAlphaComponent(0.25)
        cell.textLabel?.textColor = colors[indexPath.section]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.item)")
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        let scale = (40 * ((CGFloat(section) + 0.30)/2))
        let height = super.tableView(tableView, heightForHeaderInSection: section)
        
        return height + scale
    }
    
}
