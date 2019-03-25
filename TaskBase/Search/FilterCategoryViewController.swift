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

class FilterCategoryViewController: UIViewController {

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
    let categoryList = FilterCategory.list()
    private let cellId = "SearchDetailTableViewCell"
    private let disposeBag = DisposeBag()
    var viewModel: FilterCategoryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = RxTableViewSectionedReloadDataSource<SectionCategory>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: SearchDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! SearchDetailTableViewCell
                cell.titleLabel.text = item.name
                return cell
            }
        )

        guard let viewModel = self.viewModel else { return }

        viewModel.categories
            .bind(to: categoryTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categoryList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryCell", for: indexPath)
//        cell.textLabel?.text = categoryList[indexPath.row].name
//        return cell
//    }

}
