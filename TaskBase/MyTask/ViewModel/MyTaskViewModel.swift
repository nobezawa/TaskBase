//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

protocol MyTaskViewModelProtocol {
    init(mediator: MyTaskMediatorProtocol)
}

class MyTaskViewModel: MyTaskViewModelProtocol {
    private var tasks: [MyTask]
    private let mediator: MyTaskMediatorProtocol

    required init(mediator: MyTaskMediatorProtocol) {
        self.mediator = mediator
        self.tasks = mediator.store
    }
}
