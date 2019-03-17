//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift

protocol MyTaskMediatorProtocol {
    var store: [MyTask] { get set }
    var controllers:[String: UIViewController] { get }
    var subject: BehaviorSubject<[MyTask]> { get }
    var currentMyTask: BehaviorSubject<MyTask?> { get }
    func nextVC(currentVCname: String) -> UIViewController?
    func rootVC() -> UIViewController
    func setCurrentTask(task: MyTask)
    //func updateStore(_ store: [MyTask])
}

final class MyTaskMediator: MyTaskMediatorProtocol {
    var store: [MyTask]
    var subject: BehaviorSubject<[MyTask]>
    var controllers:[String: UIViewController]
    var currentMyTask: BehaviorSubject<MyTask?>

    init() {
        let store =  DemoMyTask.sampleTask()
        self.store = store
        self.subject = BehaviorSubject(value: store)
        self.controllers = MyTaskMediator.initializeVC()
        self.currentMyTask = BehaviorSubject(value: nil)
    }

    func prepare() {
        let firstVC = controllers["first"]! as! TaskListViewController
        let firstViewModel = TaskListViewModel(mediator: self)
        firstVC.viewModel = firstViewModel
        self.controllers["first"] = firstVC

        let secondVC = controllers["second"] as! TodoListViewController
        let secondViewModel = TodoListViewModel(mediator: self)
        secondVC.viewModel = secondViewModel
        self.controllers["second"] = secondVC

        let thirdVC = controllers["third"] as! EditTodoViewController
        let thirdViewModel = EditTodoViewModel(mediator: self)
        thirdVC.viewModel = thirdViewModel
        self.controllers["third"] = thirdVC
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

    func setCurrentTask(task: MyTask) {
        self.currentMyTask.onNext(task)
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
