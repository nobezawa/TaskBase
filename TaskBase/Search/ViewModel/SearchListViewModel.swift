//
// Created by 延澤拓郎 on 2019-03-22.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import Differentiator
import RxCocoa
import RxSwift

struct SectionSearchTask {
    var items: [Item]
}

extension SectionSearchTask: SectionModelType {
    typealias Item = SearchTask
    init(original: SectionSearchTask, items: [Item]) {
        self = original
        self.items = items
    }
}

final class SearchListViewModel {
    let tasks: BehaviorRelay<[SectionSearchTask]> = BehaviorRelay(value: [])

    init() {
        let data = DemoSearchTask.sample()
        self.tasks.accept([SectionSearchTask(items: data)])
    }
}
