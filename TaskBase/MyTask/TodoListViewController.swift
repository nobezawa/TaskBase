//
//  TodoListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/10.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class TodoListViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            self.todoTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }
    
    let TODO = DemoMyTodo.sample()
    let cellId = "ImageTextTableCell"
    var viewModel: TodoListViewModel?
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionMyTodo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(editBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn

        let dataSource = RxTableViewSectionedReloadDataSource<SectionMyTodo>(
            configureCell: {dataSource, tableView, indexPath, item in
                let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: "ImageTextTableCell", for: indexPath) as! ImageTextTableCell
                cell.titleLabel.text = item.title
                cell.cellImage.image = UIImage(named: "uncheck_box")
                return cell
            }
        )
        self.dataSource = dataSource
        guard let viewModel = self.viewModel else { return }

        viewModel.todos
            .bind(to: todoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        self.todoTableView.rx.itemSelected
            .subscribe(onNext: {_ in
                let vc = VCFactory.create(for: .editTodo)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

    }

    @objc internal func editBtnClicked(sender: UIButton) {
        let vc = VCFactory.create(for: .editTodo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
