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
    @IBOutlet weak var editTableView: UITableView!
    
    let TODO = DemoMyTodo.sample()
    let cellId = "ImageTextTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(finishBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
        
        let nib = UINib(nibName: cellId, bundle: nil)
        self.editTableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ImageTextTableCell
        let data = TODO[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.cellImage.image = UIImage(named: "delete_icon")
        return cell
    }
    
    @objc internal func finishBtnClicked(sender: UIButton) {
        print("Finish Btn")
    }

}
