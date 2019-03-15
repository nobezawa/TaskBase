//
//  TaskListViewModel.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/14.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

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

final class TaskListViewModel {
    private var tasks: [MyTask]
    private let mediator: MyTaskMediatorProtocol

    init(mediator: MyTaskMediatorProtocol) {
        self.mediator = mediator
        self.tasks = mediator.store
    }
}
