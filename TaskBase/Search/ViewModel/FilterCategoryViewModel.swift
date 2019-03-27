//
// Created by 延澤拓郎 on 2019-03-25.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
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
    var categoryList: [CategoryModel] = [WorkCategory(), LifeCategory()].sorted(by: {$0.id < $1.id})
    var categories: BehaviorRelay<[SectionCategory]> = BehaviorRelay(value: [])
    let height: Observable<CGFloat> = Observable.just(CGFloat(50 * 2))
    private let disposeBag = DisposeBag()

    required init(mediator: SearchTaskMediatorProtocol) {
        super.init(mediator: mediator)

        self.categories.accept([SectionCategory(items: self.categoryList)])
    }

    func filterCategory(category: CategoryModel) {
        mediator.filterTasks(category: category)
    }

    func updateCategoryView(category: CategoryModel) {
        let reverseSelected = {(category: CategoryModel) -> CategoryModel in
            var copyCategory = category
            copyCategory.selected = !copyCategory.selected
            return copyCategory
        }

        let unCheckSelected = {(category: CategoryModel) -> CategoryModel in
            var copyCategory = category
            copyCategory.selected = false
            return copyCategory
        }

        let reverseSubscription = Observable
            .from(categoryList)
            .filter { $0.id == category.id }
            .map { reverseSelected($0) }

        let unCheckSubscription = Observable
            .from(categoryList)
            .filter { $0.id != category.id }
            .map { unCheckSelected($0) }

        Observable
            .combineLatest(reverseSubscription, unCheckSubscription) { [$0, $1] }
            .subscribe(onNext: {[weak self] (categoryList: [CategoryModel]) in
                guard let self = self else { return }
                self.categories.accept([SectionCategory(items: categoryList.sorted(by: {$0.id < $1.id}))])
            })
            .disposed(by: disposeBag)
    }
}
