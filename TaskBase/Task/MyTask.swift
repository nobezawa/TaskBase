//
//  MyTask.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

struct MyTask {
    var title: String = ""
}

class DemoMyTask {
    static func sampleTask() -> [MyTask] {
        let task1 = MyTask(title: "確定申告のタスク")
        let task2 = MyTask(title: "結婚式のタスク")
        return [task1, task2]
    }
}
