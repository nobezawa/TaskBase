//
//  TodoListViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/10.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    let TODO = DemoMyTodo.sample()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(editBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = TODO[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCFactory.create(for: .editTodo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc internal func editBtnClicked(sender: UIButton) {
        let vc = VCFactory.create(for: .editTodo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
