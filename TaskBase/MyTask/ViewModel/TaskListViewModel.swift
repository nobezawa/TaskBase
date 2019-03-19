//
//  TaskListViewModel.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/14.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Differentiator

struct SectionMyTask {
    var items: [Item]
}

extension SectionMyTask: SectionModelType {
    typealias Item = MyTask
    init(original: SectionMyTask, items: [Item]) {
        self = original
        self.items = items
    }
}

final class TaskListViewModel: MyTaskViewModel {
    var tasks: BehaviorRelay<[SectionMyTask]> = BehaviorRelay(value: [])
    let taskCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var store: [MyTask] = []

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.subject.subscribe(onNext: { tasks in
            let sections = [SectionMyTask(items: tasks)]
            self.tasks.accept(sections)
            self.store = tasks
            self.taskCount.accept(tasks.count)
        })
    }

    func nextVC() -> UIViewController? {
        let vc = self.mediator.nextVC(currentVCname: "TodoListVC")
        return vc
    }

    func tapTask(_ task: MyTask) {
        self.mediator.setCurrentTask(task: task)
    }
}
