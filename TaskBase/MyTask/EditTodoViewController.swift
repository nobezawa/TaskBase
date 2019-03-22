//
//  EditTodoViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class EditTodoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            self.editTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }
    @IBOutlet weak var editTableViewHeight: NSLayoutConstraint!

    let cellId = "ImageTextFieldTableViewCell"
    var viewModel: EditTodoViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }

        settingEditBtn(viewModel: viewModel)
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn

        let dataSource = RxTableViewSectionedReloadDataSource<SectionMyTodo>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: ImageTextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! ImageTextFieldTableViewCell

                return self!.addSettingToImage(cell: self!.syncEditingText(cell: cell, item: item), item: item)
            }
        )
        
        viewModel.currentTitle
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.todos
            .bind(to: editTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.tableViewHeight
            .bind(to: editTableViewHeight.rx.constant)
            .disposed(by: disposeBag)
    }

    private func addSettingToImage(cell: ImageTextFieldTableViewCell, item: MyTodo) -> ImageTextFieldTableViewCell {
        cell.cellImageView.image = UIImage(named: "delete_icon")
        let tapGesture = UITapGestureRecognizer()
        cell.cellImageView.addGestureRecognizer(tapGesture)
        cell.cellImageView.isUserInteractionEnabled = true

        guard let viewModel = self.viewModel else { return  cell }

        _ = tapGesture.rx.event.subscribe(onNext: { _ in
            viewModel.removeTodo(item)
        })
        .disposed(by: self.disposeBag)

        return cell
    }

    private func syncEditingText(cell: ImageTextFieldTableViewCell, item: MyTodo) -> ImageTextFieldTableViewCell {
        cell.cellTextField.text = item.title
        guard let viewModel = self.viewModel else { return  cell }
        _ = cell.cellTextField.rx.text
                .skip(1)
                .subscribe(onNext: { input in
                    guard let text = input else { return }
                    //print(text)
                    viewModel.syncText(todo: item, updateText: text)
                })
                .disposed(by: self.disposeBag)

        return cell
    }
}

extension EditTodoViewController {

    private func settingEditBtn(viewModel: EditTodoViewModel) {
        let btn = UIBarButtonItem(title: "完了", style: .plain, target: nil, action: nil)

        viewModel.isEnableFinishBtn.subscribe(onNext: { isEnable in
            btn.isEnabled = isEnable
        })
        .disposed(by: disposeBag)

        btn.rx.tap.subscribe(onNext: { _ in
            viewModel.updateEditedTodo()
        })
        .disposed(by: disposeBag)

        self.navigationItem.rightBarButtonItem = btn
    }
}
