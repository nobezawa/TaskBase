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
    let todos: BehaviorRelay<[SectionSearchTodo]> = BehaviorRelay(value: [])
    let height: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)
        let data = DemoSearchTodo.sample()
        self.todos.accept([SectionSearchTodo(items: data)])
        let height = data.count * 50
        self.height.accept(CGFloat(height))
    }


    // TODO: Remove
    func cloneTask() {
        let realm = try! Realm()
        let todo1 = ReMyTodo()
        todo1.title = "銀行振り込みをする"
        let todo2 = ReMyTodo()
        todo2.title = "青色申告を申請する"

        let task = ReMyTask()
        task.title = "確定申告のタスク"
        task.todos.append(todo1)
        task.todos.append(todo2)


        let todo3 = ReMyTodo()
        todo3.title = "挨拶をする"
        let todo4 = ReMyTodo()
        todo4.title = "プロポーズをする"

        let task2 = ReMyTask()
        task2.title = "ご成婚する"
        task2.todos.append(todo3)
        task2.todos.append(todo4)

        try! realm.write {
            realm.add(task)
            realm.add(task2)
        }
    }

    func selectTask() {
        let realm = try! Realm()
        let tasks = realm.objects(ReMyTask.self)
        print(Array(tasks).map({ (data: ReMyTask) in data.taskStruct }))
    }

}
