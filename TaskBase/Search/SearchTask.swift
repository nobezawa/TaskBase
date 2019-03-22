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
        return [task1]
    }
}
