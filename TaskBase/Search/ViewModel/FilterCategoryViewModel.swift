//
// Created by 延澤拓郎 on 2019-03-25.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

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
    let categories: Observable<[SectionCategory]> =
            Observable.just([SectionCategory(items: [WorkCategory(), LifeCategory()])])

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)
    }
}
