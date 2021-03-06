//
//  VCFactory.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/10.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import Foundation
import UIKit

struct StoryboardRepresentation {
    let bundle: Bundle?
    let storyboardName: String
    let storyboardId: String
}

enum TypeOfViewController {
    case searchList
    case taskList
    case shareList
    case todoList
    case editTodo
    case filterCategory
    case searchDetail
    case shareDetail
    case editShare
}

extension TypeOfViewController {
    func storyboardRepresentation() -> StoryboardRepresentation {
        switch self {
        case .searchList:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "SearchListViewController",
                storyboardId: "SearchListViewController"
            )
        case .taskList:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "TaskListViewController",
                storyboardId: "TaskListViewController"
            )
        case .shareList:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "ShareListViewController",
                storyboardId: "ShareListViewController"
            )
        case .todoList:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "TodoListViewController",
                storyboardId: "TodoListViewController"
            )
        case .editTodo:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "EditTodoViewController",
                storyboardId: "EditTodoViewController"
            )
        case .filterCategory:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "FilterCategoryViewController",
                storyboardId: "FilterCategoryViewController"
            )
        case .searchDetail:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "SearchDetailViewController",
                storyboardId: "SearchDetailViewController"
            )
        case .shareDetail:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "ShareDetailViewController",
                storyboardId: "ShareDetailViewController"
            )
        case .editShare:
            return StoryboardRepresentation(
                bundle: nil,
                storyboardName: "EditShareViewController",
                storyboardId: "EditShareViewController"
            )
        }
    }
}

class VCFactory: NSObject {
    static func create(for typeOfVC: TypeOfViewController) -> UIViewController {
        let metadata = typeOfVC.storyboardRepresentation()
        let sb = UIStoryboard(name: metadata.storyboardName, bundle: metadata.bundle)
        let vc = sb.instantiateViewController(withIdentifier: metadata.storyboardId)
        return vc
    }
}
