//
//  MyTodo.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

struct MyTodo {
    var title: String = ""
}

class DemoMyTodo {
    static func sample() -> [MyTodo] {
        let todo1 = MyTodo(title: "経費計算をする")
        let todo2 = MyTodo(title: "ふるさと納税の金額を計算をする")
        return [todo1, todo2]
    }
}
