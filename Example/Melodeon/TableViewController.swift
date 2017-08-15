//
//  ViewController.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import UIKit
import Melodeon

class TableViewController: MelodeonController {

    let colors:[UIColor] = [UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1.0),
                            UIColor(red: 253/255, green: 179/255, blue: 37/255, alpha: 1.0),
                            UIColor(red: 251/255, green: 70/255, blue: 70/255, alpha: 1.0),
                            UIColor(red: 76/255, green: 177/255, blue: 210/255, alpha: 1.0),
                            UIColor(red: 253/255, green: 179/255, blue: 235/255, alpha: 1.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = ListDataSource()
        self.removeTrailingCells = true

    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .white
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.backgroundColor = colors[indexPath.section].withAlphaComponent(0.25)
        cell.textLabel?.textColor = colors[indexPath.section]
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = super.tableView(tableView, viewForHeaderInSection: section) as? UITableViewHeaderFooterView else {
            return nil
        }
        view.contentView.backgroundColor = colors[section]

        return view
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.item)")
    }

}

