//
// Created by 延澤拓郎 on 2019-03-24.
// Copyright (c) 2019 延澤拓郎. All rights reserved.
//

import RxSwift
import UIKit

protocol SearchTaskMediatorProtocol {
    var tasks: BehaviorSubject<[SearchTask]> { get }
    var controllers:[String: UIViewController] { get }
    var currentTask: BehaviorSubject<SearchTask?> { get }

    func rootVC() -> UIViewController
    func prepare()
    func nextVC(getVCName: String) -> UIViewController?
    func setCurrent(task: SearchTask)
}

final class SearchTaskMediator: SearchTaskMediatorProtocol {
    var tasks: BehaviorSubject<[SearchTask]>
    var controllers:[String: UIViewController]
    var currentTask: BehaviorSubject<SearchTask?> = BehaviorSubject(value: nil)

    init() {
        self.tasks = BehaviorSubject(value: DemoSearchTask.sample())
        self.controllers = SearchTaskMediator.initializeVC()
    }

    func rootVC() -> UIViewController {
        return controllers["searchList"]!
    }

    func prepare() {
        let firstVC = controllers["searchList"]! as! SearchListViewController
        let firstViewModel = SearchListViewModel(mediator: self)
        firstVC.viewModel = firstViewModel

        let secondVC = controllers["searchDetail"]! as! SearchDetailViewController
        let secondViewModel = SearchDetailViewModel(mediator: self)
        secondVC.viewModel = secondViewModel

        let thirdVC = controllers["filterCategory"] as! FilterCategoryViewController
        let thirdViewModel = FilterCategoryViewModel(mediator: self)
        thirdVC.viewModel = thirdViewModel
    }

    func nextVC(getVCName: String) -> UIViewController? {
        return controllers[getVCName]
    }

    func setCurrent(task: SearchTask) {
        currentTask.onNext(task)
    }

    private static func initializeVC() -> [String: UIViewController] {
        let searchListViewController = VCFactory.create(for: .searchList)
        searchListViewController.tabBarItem = UITabBarItem(title: "探す", image: UIImage(named: "search"), tag: 2)

        let searchDetailViewController = VCFactory.create(for: .searchDetail)
        let filterCategoryViewController = VCFactory.create(for: .filterCategory)

        return [
            "searchList": searchListViewController,
            "searchDetail": searchDetailViewController,
            "filterCategory": filterCategoryViewController
        ]
    }
}
