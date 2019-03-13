//
//  EditShareViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

class EditShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let todos = [ShareTodoModel(title: "hoge")]
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(finishBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditShareCell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
    
    @objc private func finishBtnClicked(sender: UIButton) {
        print("finish!!")
    }

}
