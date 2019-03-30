//
// Created by 延澤拓郎 on 2019-03-22.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

struct SearchTask {
    let id: Int
    let title: String
    let description: String
    let category: CategoryModel
    let todos: [SearchTodo]
}

struct SearchTodo {
    let id: Int
    let title: String
}

class DemoSearchTask {
    static func sample() -> [SearchTask] {

        let task1 = SearchTask(id: 1, title: "確定申告", description: "青色申告のタスク", category: WorkCategory(), todos: [
            SearchTodo(id: 1, title: "1年間の経費を計算する"),
            SearchTodo(id: 2, title: "確定申告書類を作成する"),
            SearchTodo(id: 3, title: "e-Taxもしくは税務署に書類を提出する"),
        ])

        let task2 = SearchTask(id: 2, title: "結婚式の準備", description: "結婚式のタスク", category: LifeCategory(), todos: [
            SearchTodo(id: 1, title: "両家に挨拶をする"),
            SearchTodo(id: 2, title: "結婚式の日取りを決める"),
            SearchTodo(id: 3, title: "結婚式の予算を決める"),
            SearchTodo(id: 4, title: "結婚式の式場を決める"),
            SearchTodo(id: 5, title: "結婚式の内容を決める"),
        ])
        return [task1, task2]
    }
}

