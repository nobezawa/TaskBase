//
//  SearchListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class SearchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var taskTableView: UITableView!

    @IBAction func categoryButtonTap(_ sender: Any) {
        let vc = VCFactory.create(for: .filterCategory)
        self.present(vc, animated: true, completion: nil)
    }
    
    let tasks = DemoSearchTaskModel.sample()
    let cellId = "SearchListCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: nil)
        taskTableView.register(nib, forCellReuseIdentifier: cellId)
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchListCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchListCell
        let data = tasks[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.countLabel.text = "\(data.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCFactory.create(for: .searchDetail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
