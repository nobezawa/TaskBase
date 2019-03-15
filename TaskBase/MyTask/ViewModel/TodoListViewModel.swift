//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import RxSwift
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
    var todos: Observable<[SectionMyTodo]> = Observable.just([SectionMyTodo(items: DemoMyTodo.sample())])

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

// TODO: currentMyTaskを設定する処理を書く
//        _ = mediator.currentMyTask.subscribe(onNext: { myTask in
//            guard let task = myTask else {
//                self.todos = Observable.just([])
//                return
//            }
//            let sections = [SectionMyTodo(items: task.todos)]
//            self.todos = Observable.just(sections)
//        })
    }
}
