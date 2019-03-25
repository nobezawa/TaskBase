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
}

struct WorkCategory: CategoryModel {
    var id: Int = 0
    var name: String = "仕事"
}

//extension WorkCategory: Equatable {
//    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//}

struct LifeCategory: CategoryModel {
    var id: Int = 1
    var name: String = "生活"
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
