//
// Created by 延澤拓郎 on 2019-03-15.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class EditTodoViewModel: MyTaskViewModel {
    let todos: BehaviorRelay<[SectionMyTodo]> = BehaviorRelay(value: [])
    let currentTitle: BehaviorRelay<String> = BehaviorRelay(value: "")
    let tableViewHeight: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)
    let isEnableFinishBtn: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()

    required init(mediator: MyTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.editingTodos.subscribe(onNext: { [weak self] todos in
            let sections = [SectionMyTodo(items: todos)]
            self?.todos.accept(sections)
            let height = CGFloat(todos.count * 50)
            self?.tableViewHeight.accept(height)
        })
        .disposed(by: disposeBag)
        
        _ = mediator.currentMyTask.subscribe(onNext: {myTask in
            guard let task = myTask else { return }
            self.currentTitle.accept(task.title)
        })
        .disposed(by: disposeBag)

        _ = mediator.isEditing
            .distinctUntilChanged({ $0 })
            .subscribe(onNext: { [weak self] in self?.isEnableFinishBtn.accept($0)} )
            .disposed(by: disposeBag)
    }

    func removeTodo(_ todo: MyTodo) {
        self.mediator.removeEditingTodo(todo: todo)
    }

    func syncText(todo: MyTodo, updateText: String) {
        var copyTodo = todo
        copyTodo.title = updateText
        self.mediator.syncTodoTitle(todo: copyTodo)
    }

    func updateEditedTodo() {
        self.mediator.updateTodo()
    }
}
