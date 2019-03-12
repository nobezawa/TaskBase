//
//  ShareTaskModel.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

struct ShareTaskModel {
    var title: String = ""
}

struct ShareTodoModel {
    var title: String = ""
}

class DemoShareTaskModel {
    static func sample() -> [ShareTaskModel] {
        let task1 = ShareTaskModel(title: "確定申告のタスク")
        let task2 = ShareTaskModel(title: "結婚式のタスク")
        return [task1, task2]
    }
}
