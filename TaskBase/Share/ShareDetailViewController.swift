//
//  ShareDetailViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

class ShareDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let todos = [ShareTodoModel(title: "hoge")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(editBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShareDetailCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
    
    @objc private func editBtnClicked(sender: UIButton) {
        let vc = VCFactory.create(for: .editShare)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
