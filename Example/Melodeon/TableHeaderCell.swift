//
//  MyHeaderCell.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import Melodeon

class TableHeaderCell: MelodeonHeaderCell {

    override var collapsed: Bool {
        didSet {
            label.text = isCollapsed ? "+" : "-"
        }
    }

    let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    override func setupViews() {
        super.setupViews()
        separator.isHidden = true
        self.contentView.addSubview(label)
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -layoutMargins.right).isActive = true
    }
}
