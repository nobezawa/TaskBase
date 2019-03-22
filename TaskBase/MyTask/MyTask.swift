//
//  MyTask.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import Realm
import RealmSwift

struct MyTask {
    let id: String
    let title: String
    let finished: Bool
    var todos: [MyTodo]
}

final class ReMyTask: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var finished = false
    let todos = List<ReMyTodo>()
    
    override static func primaryKey() -> String? {
        return "id"
    }

    var taskStruct: MyTask {
        get {
            let todos = Array(self.todos)
            return MyTask(id: self.id, title: self.title, finished: self.finished, todos: todos.map({ (data: ReMyTodo) in data.todoStruct}))
        }
    }
}

class DemoMyTask {
    static func sampleTask() -> [MyTask] {
        let task1 = MyTask(id: "1", title: "確定申告のタスク", finished: false, todos: DemoMyTodo.sample())
        let task2 = MyTask(id: "2", title: "結婚式のタスク", finished: false, todos: DemoMyTodo.sample())
        return [task1, task2]
    }
}
