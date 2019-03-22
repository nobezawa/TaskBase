//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Differentiator

struct SectionMyTodo {
    var items: [Item]
}

extension SectionMyTodo: SectionModelType {
    typealias Item = MyTodo
    init(original: SectionMyTodo, items: [Item]) {
        self = original
        self.items = items
    }
}

final class TodoListViewModel: MyTaskViewModel {
    var currentTask: MyTask?
    var currentTitle: Observable<String?>  = Observable.empty()
    var todos: BehaviorRelay<[SectionMyTodo]> = BehaviorRelay(value: [])
    var tableViewHeight: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.currentMyTask.subscribe(onNext: { myTask in
            guard let task = myTask else {
                self.todos.accept([])
                self.currentTask = nil
                self.currentTitle = Observable.just(nil)
                return
            }
            let sections = [SectionMyTodo(items: task.todos)]
            self.todos.accept(sections)
            self.currentTask = task
            self.currentTitle = Observable.just(task.title)
            let height = CGFloat(task.todos.count * 50)
            self.tableViewHeight.accept(height)
        })
    }

    func updateFinished(_ task: MyTask) {
        mediator.updateStore(task: task)
        mediator.setCurrentTask(task: task)
    }

    func nextVC() -> UIViewController? {
        let vc = self.mediator.nextVC(currentVCname: "EditTodoVC")
        return vc
    }

    func setTask() {
        guard let task = self.currentTask else { return }
        self.mediator.setCurrentTask(task: task)
    }

    func saveTodoState(_ todo: MyTodo) {
        MyTaskRepository.updateFinished(todoId: todo.id, value: todo.finished)
    }

    func saveTaskState(_ task: MyTask)  {
        MyTaskRepository.updateFinished(taskId: task.id, value: task.finished)
    }
}
