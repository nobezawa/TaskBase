//
//  FilterCategoryViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class FilterCategoryViewController: UIViewController {

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var categoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            categoryTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }

    private let cellId = "FilterCategoryTableViewCell"
    private let disposeBag = DisposeBag()
    var viewModel: FilterCategoryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = self.viewModel else { return }

        let dataSource = RxTableViewSectionedReloadDataSource<SectionCategory>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: FilterCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! FilterCategoryTableViewCell
                cell.titleLabel.text = item.name
                cell.doneImageView.image = item.selected ? UIImage(named: "done") : UIImage(named: "not_done")
                return cell
            }
        )

        viewModel.categories
            .bind(to: categoryTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.height
            .bind(to: categoryTableViewHeight.rx.constant)
            .disposed(by: disposeBag)

        categoryTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let category = viewModel.categoryList[indexPath.row]
                viewModel.filterCategory(category: category)
                viewModel.updateCategoryView(category: category)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}
