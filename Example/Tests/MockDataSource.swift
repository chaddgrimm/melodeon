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


    public override var sections:[Any] {
        return ["List A", "List B", "List C", "List D", "List E"]
    }


}
