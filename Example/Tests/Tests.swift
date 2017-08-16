import UIKit
import XCTest
import Melodeon

class Tests: XCTestCase {
    
    var tableViewController:MelodeonController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.tableViewController = MelodeonController()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testSectionCount() {
        let passed = self.tableViewController.sections.count == 0 && self.tableViewController.numberOfSections(in: self.tableViewController.tableView) == 0
        XCTAssert(passed, "Section count is zero.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
