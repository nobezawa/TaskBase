//
// Created by 延澤拓郎 on 2019-03-22.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

struct SearchTask {
    let id: String
    let title: String
    let description: String
    let category: CategoryModel
    let todos: [SearchTodo]
}

struct SearchTodo {
    let id: String
    let title: String
}

class DemoSearchTask {
    static func sample() -> [SearchTask] {

        let task1 = SearchTask(id: "1", title: "確定申告", description: "青色申告のタスク", category: WorkCategory(), todos: [
            SearchTodo(id: "1", title: "納税する")
        ])

        let task2 = SearchTask(id: "1", title: "結婚式の準備", description: "結婚式のタスク", category: LifeCategory(), todos: [
            SearchTodo(id: "1", title: "相手を探す")
        ])
        return [task1, task2]
    }
}

class DemoSearchTodo {
    static func sample() -> [SearchTodo] {
        let todo1 = SearchTodo(id: "1", title: "納税する")
        return [todo1]
    }
}
