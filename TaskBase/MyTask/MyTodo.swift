//
//  MyTodo.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

struct MyTodo {
    let id: Int
    var title: String = ""
    var finished: Bool = false
}

class DemoMyTodo {
    static func sample() -> [MyTodo] {
        let todo1 = MyTodo(id: 1, title: "経費計算をする", finished: false)
        let todo2 = MyTodo(id: 2, title: "ふるさと納税の金額を計算をする", finished: false)
        return [todo1, todo2]
    }
}
