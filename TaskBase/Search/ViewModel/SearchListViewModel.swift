//
// Created by 延澤拓郎 on 2019-03-22.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
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

final class SearchListViewModel: SearchViewModel {
    let tasks: BehaviorRelay<[SectionSearchTask]> = BehaviorRelay(value: [])
    let tableViewHeight: BehaviorRelay<CGFloat> = BehaviorRelay(value: 0)

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)
        let data = DemoSearchTask.sample()
        self.tasks.accept([SectionSearchTask(items: data)])
        let height = data.count * 50
        self.tableViewHeight.accept(CGFloat(height))
    }

    func searchDetailVC() -> UIViewController? {
        return mediator.nextVC(getVCName: "searchDetail")
    }

    func categoryVC() -> UIViewController? {
        return mediator.nextVC(getVCName: "filterCategory")
    }

    func searchTasks() -> [SearchTask] {
        return try! mediator.tasks.value()
    }

    func setCurrent(task: SearchTask) {
        mediator.setCurrent(task: task)
    }
}
