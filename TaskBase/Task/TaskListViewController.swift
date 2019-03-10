//
//  TaskListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let TODO = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTaskCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = TODO[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCFactory.create(for: .todoList)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
