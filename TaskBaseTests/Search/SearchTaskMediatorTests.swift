//
//  SearchTaskMediatorTests.swift
//  TaskBaseTests
//
//  Created by 延澤拓郎 on 2019/04/19.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import XCTest
@testable import TaskBase

class SearchTaskMediatorTests: XCTestCase {
    
    var mediator: SearchTaskMediator!

    override func setUp() {
        self.mediator = SearchTaskMediator()
        self.mediator.prepare()
    }
    
    func testRootVC() {
        let vc = self.mediator.rootVC()
        XCTAssertNotNil(vc)
        XCTAssertTrue(vc is SearchListViewController)
    }
    
    func testNextVC() {
        self.mediator.nextVC(getVCName: "searchList").flatMap { vc in
            XCTAssertTrue(vc is SearchListViewController)
        }
        
        self.mediator.nextVC(getVCName: "searchDetail").flatMap { vc in
            XCTAssertTrue(vc is SearchDetailViewController)
        }
        
        self.mediator.nextVC(getVCName: "filterCategory").flatMap { vc in
            XCTAssertTrue(vc is FilterCategoryViewController)
        }
    }
}
