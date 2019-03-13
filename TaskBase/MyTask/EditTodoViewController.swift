//
//  EditTodoViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class EditTodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!

    let TODO = DemoMyTodo.sample()

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(finishBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EditTodoCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = TODO[indexPath.row].title
        return cell
    }
    
    @objc internal func finishBtnClicked(sender: UIButton) {
        print("Finish Btn")
    }

}
