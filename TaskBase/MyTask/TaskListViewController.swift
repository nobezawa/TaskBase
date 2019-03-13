//
//  TaskListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let TODO = DemoMyTask.sampleTask()
    let cellId = "ImageTextTableCell"
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
        
        let nib = UINib(nibName: cellId, bundle: nil)
        self.taskTableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ImageTextTableCell
        let data = TODO[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.cellImage.image = UIImage(named: "uncheck_task")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCFactory.create(for: .todoList)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
