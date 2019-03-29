//
//  MyTodo.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import Realm
import RealmSwift

struct MyTodo {
    let id: String
    var title: String = ""
    var finished: Bool = false
}

final class ReMyTodo: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var finished = false

    override static func primaryKey() -> String? {
        return "id"
    }

    var todoStruct: MyTodo {
        get {
            return MyTodo(id: self.id, title: self.title, finished: self.finished)
        }
    }
}
