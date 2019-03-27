//
//  CategoryModel.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

protocol CategoryModel {
    var id: Int { get }
    var name: String { get }
    var selected: Bool { get set }
}

struct WorkCategory: CategoryModel {
    var id: Int = 0
    var name: String = "仕事"
    var selected: Bool = false
}

struct LifeCategory: CategoryModel {
    var id: Int = 1
    var name: String = "生活"
    var selected: Bool = false
}

enum FilterCategory {
    case work
    case life
}

extension FilterCategory {
    func model() -> CategoryModel {
        switch self {
        case .work:
            return WorkCategory.init()
        case .life:
            return LifeCategory.init()
        }
    }
    
    static func list() -> [CategoryModel] {
        return [WorkCategory.init(), LifeCategory.init()]
    }
}
