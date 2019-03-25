//
// Created by 延澤拓郎 on 2019-03-21.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Realm
import RealmSwift
import Differentiator

struct SectionSearchTodo {
    var items: [Item]
}

extension SectionSearchTodo: SectionModelType {
    typealias Item = SearchTodo

    init(original: SectionSearchTodo, items: [Item]) {
        self = original
        self.items = items
    }
}

final class SearchDetailViewModel: SearchViewModel {
    let curentTask: BehaviorRelay<SearchTask?> = BehaviorRelay(value: nil)
    let todos: BehaviorRelay<[SectionSearchTodo]> = BehaviorRelay(value: [])
    let height: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)
    let notificationRealm: PublishRelay<Bool> = PublishRelay()
    var token: NotificationToken?


    private let realm = try! Realm()
    private let disposeBag = DisposeBag()

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)

        _ = mediator.currentTask.subscribe(onNext: { [weak self] searchTask in
            guard let task = searchTask else { return }
            self?.todos.accept([SectionSearchTodo(items: task.todos)])
            let height = task.todos.count * 50
            self?.height.accept(CGFloat(height))
            self?.curentTask.accept(task)
        })
        .disposed(by: disposeBag)

        token = realm.observe { [weak self] _, _ in
            self?.notificationRealm.accept(true)
        }
    }

    func cloneTask() {
        guard let task = curentTask.value else { return }

        let todos = task.todos.map { todo -> ReMyTodo in
            let reMyTodo = ReMyTodo()
            reMyTodo.title = todo.title
            return reMyTodo
        }

        let myTask = ReMyTask()
        myTask.title = task.title
        todos.forEach { myTask.todos.append($0) }

        try! realm.write {
            realm.add(myTask)
        }
    }

    func selectTask() {
        let realm = try! Realm()
        let tasks = realm.objects(ReMyTask.self)
        print(Array(tasks).map({ (data: ReMyTask) in data.taskStruct }))
    }

}
