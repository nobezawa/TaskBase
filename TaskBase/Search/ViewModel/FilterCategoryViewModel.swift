//
// Created by 延澤拓郎 on 2019-03-25.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import Differentiator

struct SectionCategory {
    var items: [Item]
}

extension SectionCategory: SectionModelType {
    typealias Item = CategoryModel

    init(original: SectionCategory, items: [Item]) {
        self = original
        self.items = items
    }
}

final class FilterCategoryViewModel: SearchViewModel {
    let categoryList: [CategoryModel] = [WorkCategory(), LifeCategory()]
    var categories: Observable<[SectionCategory]>?
    let height: Observable<CGFloat> = Observable.just(CGFloat(50 * 2))

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)

        self.categories = Observable.just([SectionCategory(items: self.categoryList)])
    }

    func filterCategory(category: CategoryModel) {
        mediator.filterTasks(category: category)
    }
}
