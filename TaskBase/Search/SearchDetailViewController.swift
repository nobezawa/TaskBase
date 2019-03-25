//
//  SearchDetailViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var todoTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            todoTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }
    @IBOutlet weak var todoTableViewHeight: NSLayoutConstraint!

    private let disposeBag = DisposeBag()
    private let cellId = "SearchDetailTableViewCell"
    private let alert: UIAlertController = SearchDetailViewController.setAlertController()

    var viewModel: SearchDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailText.numberOfLines = 0
        detailText.sizeToFit()
        detailText.lineBreakMode = NSLineBreakMode.byWordWrapping

        let dataSource = RxTableViewSectionedReloadDataSource<SectionSearchTodo>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: SearchDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! SearchDetailTableViewCell
                cell.titleLabel.text = item.title
                return cell
            }
        )
        guard let viewModel = self.viewModel else { return }

        viewModel.todos
            .bind(to: todoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.height
            .bind(to: todoTableViewHeight.rx.constant)
            .disposed(by: disposeBag)

        viewModel.curentTask
            .map { $0?.title }
            .bind(to: titleText.rx.text)
            .disposed(by: disposeBag)

        viewModel.curentTask
            .map{ $0?.description }
            .bind(to: detailText.rx.text)
            .disposed(by: disposeBag)

        viewModel.notificationRealm
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.present(self.alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        let copyBtn = UIBarButtonItem(title: "コピー", style: .plain, target: nil, action: nil)
        copyBtn.rx.tap
            .subscribe(onNext: { _ in
                viewModel.cloneTask()
            })
            .disposed(by: disposeBag)

        self.navigationItem.rightBarButtonItem = copyBtn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel?.token?.invalidate()
    }
}

extension SearchDetailViewController {

    static func setAlertController() -> UIAlertController {
        let ua =  UIAlertController(title: "コピーしました", message: "コピーしました", preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ua.addAction(okayButton)
        return ua
    }
}
