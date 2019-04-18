//
//  TaskBaseTests.swift
//  TaskBaseTests
//
//  Created by 延澤拓郎 on 2019/04/18.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import XCTest
@testable import TaskBase

class TaskBaseTests: XCTestCase {
    
    var mediator: MyTaskMediator!

    override func setUp() {
        super.setUp()
        self.mediator = MyTaskMediator()
        self.mediator.prepare()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRootVC() {
        let vc = self.mediator.rootVC()
        XCTAssertNotNil(vc)
        XCTAssertTrue(vc is TaskListViewController)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
