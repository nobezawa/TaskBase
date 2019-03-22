//
// Created by 延澤拓郎 on 2019-03-21.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import Realm
import RealmSwift

final class SearchDetailViewModel {

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
