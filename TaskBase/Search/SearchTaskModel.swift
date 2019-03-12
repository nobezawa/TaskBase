//
//  SearchTaskModel.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

struct SearchTaskModel {
    var title: String = ""
    var count: Int = 0
}

class DemoSearchTaskModel {
    static func sample() -> [SearchTaskModel] {
        let task1 = SearchTaskModel(title: "確定申告のタスク", count: 345)
        let task2 = SearchTaskModel(title: "経費計算のタスク", count: 100)
        return [task1, task2]
    }
}
