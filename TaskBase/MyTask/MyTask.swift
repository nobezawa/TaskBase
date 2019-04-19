//
//  MyTask.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import Realm
import RealmSwift

struct MyTask: Equatable {
    let id: String
    let title: String
    let finished: Bool
    var todos: [MyTodo]
    
    static func ==(lhs: MyTask, rhs: MyTask) -> Bool {
        return lhs.id == rhs.id
    }
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
