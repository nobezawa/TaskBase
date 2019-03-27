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

    @IBOutlet weak var taskTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            self.taskTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }

    @IBOutlet weak var taskTableViewHeight: NSLayoutConstraint!

    var viewModel: TaskListViewModel?
    private let cellId = "ImageTextTableCell"
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
                cell.cellImage.image = item.finished ? UIImage(named: "checked_task") : UIImage(named: "uncheck_task")
                return cell
            }
        )
        self.dataSource = dataSource
        guard let viewModel = self.viewModel else { return }

        viewModel.tasks
            .bind(to: taskTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.taskCount
            .subscribe(onNext: {[weak self] count in
                self?.taskTableViewHeight.constant = CGFloat(50 * count)
            })
           .disposed(by: disposeBag)

        self.taskTableView.rx.itemSelected
            .subscribe(onNext: {[weak self] index  in
                viewModel.tapTask(index: index.row)

                guard let vc = viewModel.nextVC() else { return }
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let viewModel = self.viewModel else { return }
        viewModel.reload()
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
