//
//  ShareListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

class ShareListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tasks = DemoShareTaskModel.sample()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "新規", style: .plain, target: self, action: #selector(createBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShareListCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = tasks[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCFactory.create(for: .shareDetail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func createBtnClicked(sender: UIButton) {
        print("new task")
    }
    

}
