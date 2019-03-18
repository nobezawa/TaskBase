//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import RxCocoa
import RxSwift

final class EditTodoViewModel: MyTaskViewModel {
    var todos: BehaviorRelay<[SectionMyTodo]> = BehaviorRelay(value: [])

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.editingTodos.subscribe(onNext: {todos in
            let sections = [SectionMyTodo(items: todos)]
            self.todos.accept(sections)
        })
    }
}
