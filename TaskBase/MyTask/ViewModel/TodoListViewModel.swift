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
    let currentTitle: BehaviorRelay<String>  = BehaviorRelay(value: "")
    let todos: BehaviorRelay<[SectionMyTodo]> = BehaviorRelay(value: [])
    let tableViewHeight: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)
    private let disposeBag = DisposeBag()

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.currentMyTask.subscribe(onNext: { [weak self] myTask in
            guard let self = self else { return }
            guard let task = myTask else {
                self.todos.accept([])
                self.currentTask = nil
                return
            }
            let sections = [SectionMyTodo(items: task.todos)]
            self.todos.accept(sections)
            self.currentTask = task
            self.currentTitle.accept(task.title)
            let height = CGFloat(task.todos.count * 50)
            self.tableViewHeight.accept(height)
        })
        .disposed(by: disposeBag)
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
