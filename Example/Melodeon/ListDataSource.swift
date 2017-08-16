//
//  ListDataSource.swift
//  Melodeon
//
//  Created by Chad Lee on 14/08/2017.
//  Copyright © 2017 Chad Lee. All rights reserved.
//

import Melodeon

class ListDataSource: MelodeonDataSource {

    override var sections:[Any] {
        return ["List A", "List B", "List C", "List D", "List E"]
    }

    override var headerClasses:[MelodeonHeaderCell.Type]? {
        return [TableHeaderCell.self]
    }

}
