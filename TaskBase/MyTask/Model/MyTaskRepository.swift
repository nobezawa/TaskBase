//
//  MyTaskRepository.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/20.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import Realm
import RealmSwift

final class MyTaskRepository {
    
    static func updateFinished(todoId: String, value: Bool) {
        DispatchQueue(label: "jp.cste.taskbase.update.finished", qos: .default).async {
            autoreleasepool {
                let realm = try! Realm()
                let todo = realm.object(ofType: ReMyTodo.self, forPrimaryKey: todoId)
                try! realm.write {
                    todo!.finished = value
                }
            }
        }
    }

    static func updateFinished(taskId: String, value: Bool) {
        DispatchQueue(label: "jp.cste.taskbase.update.finished", qos: .default).async {
            autoreleasepool {
                let realm = try! Realm()
                let task = realm.object(ofType: ReMyTask.self, forPrimaryKey: taskId)
                try! realm.write {
                    task!.finished = value
                }
            }
        }
    }

    static func updateTodoTitle(updateTodo: MyTodo) {
        DispatchQueue(label: "jp.cste.taskbase.update.todo", qos: .default).async {
            autoreleasepool {
                let realm = try! Realm()
                let todo = realm.object(ofType: ReMyTodo.self, forPrimaryKey: updateTodo.id)
                try! realm.write {
                    todo!.title = updateTodo.title
                }
            }
        }
    }
}
