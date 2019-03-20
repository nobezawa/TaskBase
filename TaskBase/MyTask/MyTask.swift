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
    let id: Int
    let title: String
    let finished: Bool
    let todos: [MyTodo]
}

class ReMyTask: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var finished = false
    let todos = List<ReMyTask>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class DemoMyTask {
    static func sampleTask() -> [MyTask] {
        let task1 = MyTask(id: 1, title: "確定申告のタスク", finished: false, todos: DemoMyTodo.sample())
        let task2 = MyTask(id: 2, title: "結婚式のタスク", finished: false, todos: DemoMyTodo.sample())
        return [task1, task2]
    }
}
