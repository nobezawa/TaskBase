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
    
    @IBOutlet weak var todoTableViewHeight: NSLayoutConstraint!

    let cellId = "ImageTextTableCell"
    var viewModel: TodoListViewModel?
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionMyTodo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }

        settingEditBtn(viewModel: viewModel)

        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn

        let dataSource = RxTableViewSectionedReloadDataSource<SectionMyTodo>(
            configureCell: {dataSource, tableView, indexPath, item in
                let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: "ImageTextTableCell", for: indexPath) as! ImageTextTableCell
                cell.titleLabel.text = item.title
                cell.cellImage.image = item.finished ? UIImage(named: "checked_box") : UIImage(named: "uncheck_box")
                return cell
            }
        )
        self.dataSource = dataSource

        viewModel.todos
            .bind(to: todoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.tableViewHeight
            .bind(to: todoTableViewHeight.rx.constant)
            .disposed(by: disposeBag)

        viewModel.currentTitle
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        self.todoTableView.rx.itemSelected
            .subscribe(onNext: {indexPath in
                guard let task = viewModel.currentTask else { return }
                var todos = task.todos
                var todo = todos[indexPath.row]
                todo.finished = !todo.finished
                todos[indexPath.row] = todo
                let nextTask = MyTask(id: task.id, title: task.title, finished: !todos.contains { $0.finished == false }, todos: todos)
                viewModel.updateFinished(nextTask)
                viewModel.saveTodoState(todo)
                if task.finished != nextTask.finished { viewModel.saveTaskState(nextTask) }
            })
            .disposed(by: disposeBag)
    }
}

extension TodoListViewController {

    private func settingEditBtn(viewModel: TodoListViewModel) {
        let btn = UIBarButtonItem(title: "編集", style: .plain, target: nil, action: nil)
        btn.rx.tap.subscribe(onNext: { _ in
            viewModel.setTask()
            guard let vc = viewModel.nextVC() else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem = btn
    }
}
