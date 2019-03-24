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
        let viewModel = SearchDetailViewModel()

        viewModel.todos
            .bind(to: todoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.height
            .bind(to: todoTableViewHeight.rx.constant)
            .disposed(by: disposeBag)

        let copyBtn = UIBarButtonItem(title: "コピー", style: .plain, target: nil, action: nil)
        copyBtn.rx.tap
            .subscribe(onNext: { _ in

                viewModel.cloneTask()
                //viewModel.selectTask()
                print("click copy");
            })
            .disposed(by: disposeBag)

        self.navigationItem.rightBarButtonItem = copyBtn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }
}
