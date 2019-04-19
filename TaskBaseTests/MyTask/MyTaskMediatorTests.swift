//
//  MyTaskMediatorTests.swift
//  TaskBaseTests
//
//  Created by 延澤拓郎 on 2019/04/19.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import XCTest
@testable import TaskBase

class MyTaskMediatorTests: XCTestCase {

    var mediator: MyTaskMediator!
    
    override func setUp() {
        super.setUp()
        self.mediator = MyTaskMediator()
        self.mediator.prepare()
    }
    
    func testRootVC() {
        let vc = self.mediator.rootVC()
        XCTAssertNotNil(vc)
        XCTAssertTrue(vc is TaskListViewController)
    }
    
    func testNextVC() {
        self.mediator.nextVC(currentVCname: "TaskListVC").flatMap { vc in
            XCTAssertTrue(vc is TaskListViewController)
        }
        
        self.mediator.nextVC(currentVCname: "TodoListVC").flatMap { vc in
            XCTAssertTrue(vc is TodoListViewController)
        }
        
        self.mediator.nextVC(currentVCname: "EditTodoVC").flatMap { vc in
            XCTAssertTrue(vc is EditTodoViewController)
        }
        XCTAssertNil(self.mediator.nextVC(currentVCname: "hoge"))
    }
    
    func testSetCurrentTask() {
        let todos = [MyTodo(id: "1", title: "test", finished: false)]
        let task = MyTask(id: "1", title: "test", finished: false, todos: todos)
        self.mediator.setCurrentTask(task: task)
        XCTAssertEqual(self.mediator.afterEditingTodos.count, todos.count)
    }
}
