//
//  SearchListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchListViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: cellId, bundle: nil)
            taskTableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }

    @IBAction func categoryButtonTap(_ sender: Any) {
        let vc = VCFactory.create(for: .filterCategory)
        self.present(vc, animated: true, completion: nil)
    }
    
    let tasks = DemoSearchTaskModel.sample()
    let cellId = "SearchListDefaultTableViewCell"
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
        self.taskTableView.separatorColor = UIColor.baseYellow()

        let dataSource = RxTableViewSectionedReloadDataSource<SectionSearchTask>(
            configureCell: {[weak self] dataSource, tableView, indexPath, item in
                let cell: SearchListDefaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: self!.cellId, for: indexPath) as! SearchListDefaultTableViewCell
                cell.titleLabel.text = item.title
                cell.categoryLabel.text = item.category.name
                return cell
            }
        )

        let viewModel = SearchListViewModel()

        viewModel.tasks
            .bind(to: taskTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        taskTableView.rx.itemSelected
            .subscribe(onNext: { _ in
                let vc = VCFactory.create(for: .searchDetail)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: SearchListCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchListCell
//        let data = tasks[indexPath.row]
//
//        cell.titleLabel.text = data.title
//        cell.countLabel.text = "\(data.count)"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = VCFactory.create(for: .searchDetail)
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
