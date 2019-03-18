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
    
    let TODO = DemoMyTodo.sample()
    let cellId = "ImageTextTableCell"
    var viewModel: EditTodoViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }

        let btn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(finishBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn

        let dataSource = RxTableViewSectionedReloadDataSource<SectionMyTodo>(
            configureCell: {dataSource, tableView, indexPath, item in
                let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: "ImageTextTableCell", for: indexPath) as! ImageTextTableCell
                cell.titleLabel.text = item.title
                cell.cellImage.image = UIImage(named: "delete_icon")
                return cell
            }
        )
        
        viewModel.currentTitle
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.todos
            .bind(to: editTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    @objc internal func finishBtnClicked(sender: UIButton) {
        print("Finish Btn")
    }

}
