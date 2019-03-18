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
    var currentTask: Observable<MyTask?> = Observable.empty()
    var currentTitle: Observable<String?>  = Observable.empty()
    var todos: BehaviorRelay<[SectionMyTodo]> = BehaviorRelay(value: [])

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.currentMyTask.subscribe(onNext: { myTask in
            guard let task = myTask else {
                self.todos.accept([])
                self.currentTask = Observable.empty()
                self.currentTitle = Observable.just(nil)
                return
            }
            let sections = [SectionMyTodo(items: task.todos)]
            self.todos.accept(sections)
            self.currentTask = Observable.just(task)
            self.currentTitle = Observable.just(task.title)
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
}
