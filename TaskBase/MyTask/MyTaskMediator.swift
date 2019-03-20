//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import Realm
import RealmSwift

protocol MyTaskMediatorProtocol {
    var store: [MyTask] { get set }
    var controllers:[String: UIViewController] { get }
    var subject: BehaviorSubject<[MyTask]> { get }
    var currentMyTask: BehaviorSubject<MyTask?> { get }
    var editingTodos: BehaviorSubject<[MyTodo]> { get }
    var afterEditingTodos: [MyTodo] { get }
    var isEditing: BehaviorSubject<Bool> { get }

    func nextVC(currentVCname: String) -> UIViewController?
    func rootVC() -> UIViewController
    func setCurrentTask(task: MyTask)
    func updateStore(task: MyTask)
    func removeEditingTodo(todo: MyTodo)
    func syncTodoTitle(todo: MyTodo)
}

final class MyTaskMediator: MyTaskMediatorProtocol {
    var store: [MyTask]
    var subject: BehaviorSubject<[MyTask]>
    var controllers:[String: UIViewController]
    var currentMyTask: BehaviorSubject<MyTask?>
    var editingTodos: BehaviorSubject<[MyTodo]> = BehaviorSubject(value: [])
    var afterEditingTodos: [MyTodo] = []
    var isEditing: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    init() {
        let store =  MyTaskMediator.loadTasks()
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
        self.editingTodos.onNext(task.todos)
        self.afterEditingTodos = task.todos
        self.isEditing.onNext(false)
    }

    func updateStore(task: MyTask) {
        guard let index = self.store.firstIndex(where: { $0.id == task.id} ) else { return }
        self.store[index] = task
        self.subject.onNext(self.store)
    }

    func removeEditingTodo(todo: MyTodo) {
        do {
            var todos = try self.editingTodos.value()
            if todos.isEmpty { return }
            guard let index = todos.firstIndex(where: { $0.id == todo.id}) else { return }
            todos.remove(at: index)
            self.afterEditingTodos.remove(at: index)
            self.editingTodos.onNext(todos)
            self.isEditing.onNext(true)
        } catch {
        }
    }

    func syncTodoTitle(todo: MyTodo) {
        var todos = self.afterEditingTodos
        if todos.isEmpty { return }
        guard let index = todos.firstIndex(where: { $0.id == todo.id}) else { return }
        todos[index] = todo
        self.afterEditingTodos = todos
        self.isEditing.onNext(true)
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

    private static func loadTasks() -> [MyTask] {
        let realm = try! Realm()
        let tasks = realm.objects(ReMyTask.self)
        return Array(tasks).map({ (data: ReMyTask) in data.taskStruct })
    }
}
