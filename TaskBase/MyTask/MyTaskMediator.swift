//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift

protocol MyTaskMediatorProtocol {
    var store: [MyTask] { get set }
    var subject: BehaviorSubject<[MyTask]> { get set }
    var controllers:[String: UIViewController] { get }

    func nextVC(currentVCname: String) -> UIViewController?
    func rootVC() -> UIViewController
    //func updateStore(_ store: [MyTask])
}

final class MyTaskMediator: MyTaskMediatorProtocol {
    var store: [MyTask]
    var subject: BehaviorSubject<[MyTask]>
    var controllers:[String: UIViewController]

    init() {
        let store =  DemoMyTask.sampleTask()
        self.store = store
        self.subject = BehaviorSubject(value: store)
        self.controllers = MyTaskMediator.initializeVC()
    }

    func prepare() {
        let vc = controllers["first"]! as! TaskListViewController
        let viewModel = TaskListViewModel(mediator: self)
        vc.viewModel = viewModel
        self.controllers["first"] = vc
    }

    func rootVC() -> UIViewController {
        return controllers["first"]!
    }

    func nextVC(currentVCname: String) -> UIViewController? {
        switch currentVCname {
        case "TaskListVC": return controllers["first"]
        case "TodoListVC": return controllers["second"]
        case "EditTodoVC": return controllers["third"]
        default: return nil
        }
    }

    private static func initializeVC() -> [String: UIViewController] {
        let taskListViewController = VCFactory.create(for: .taskList)
        taskListViewController.tabBarItem = UITabBarItem(title: "タスク", image: UIImage(named: "task"), tag: 0)

        let todoListViewController = VCFactory.create(for: .todoList)
        let editTodoViewController = VCFactory.create(for: .editTodo)

        return [
            "first": taskListViewController,
            "second": todoListViewController,
            "third": editTodoViewController
        ]
    }
}
