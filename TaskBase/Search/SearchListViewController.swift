//
//  SearchListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchListViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            taskTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }

    @IBAction func categoryButtonTap(_ sender: Any) {
        let vc = VCFactory.create(for: .filterCategory)
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let tasks = DemoSearchTaskModel.sample()
    let cellId = "SearchListDefaultTableViewCell"
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
        self.taskTableView.separatorColor = UIColor.baseYellow()

        let dataSource = RxTableViewSectionedReloadDataSource<SectionSearchTask>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: SearchListDefaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! SearchListDefaultTableViewCell
                cell.titleLabel.text = item.title
                cell.categoryLabel.text = item.category.name
                return cell
            }
        )

        let viewModel = SearchListViewModel()

        viewModel.tasks
            .bind(to: taskTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.tableViewHeight
            .bind(to: tableViewHeight.rx.constant)
            .disposed(by: disposeBag)

        taskTableView.rx.itemSelected
            .subscribe(onNext: { _ in
                let vc = VCFactory.create(for: .searchDetail)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

    }

}
