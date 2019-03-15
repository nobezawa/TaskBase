//
//  TaskListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class TaskListViewController: UIViewController {

    let TODO = DemoMyTask.sampleTask()
    let cellId = "ImageTextTableCell"
    @IBOutlet weak var taskTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            self.taskTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }

    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionMyTask>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn

        let dataSource = RxTableViewSectionedReloadDataSource<SectionMyTask>(
            configureCell: {dataSource, tableView, indexPath, item in
                let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: "ImageTextTableCell", for: indexPath) as! ImageTextTableCell
                cell.titleLabel.text = item.title
                cell.cellImage.image = UIImage(named: "uncheck_task")
                return cell
            }
        )

        self.dataSource = dataSource

        let sections = [
            SectionMyTask(items: TODO)
        ]

        Observable.just(sections)
            .bind(to: taskTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        self.taskTableView.rx.itemSelected
            .subscribe(onNext: { _  in
                let vc = VCFactory.create(for: .todoList)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
