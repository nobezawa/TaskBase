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
    let cellId = "ImageTextTableCell"
    var viewModel: MyTaskViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(editBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
        
        let nib = UINib(nibName: cellId, bundle: nil)
        self.todoTableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageTextTableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ImageTextTableCell
        let data = TODO[indexPath.row]

        cell.titleLabel.text = data.title
        cell.cellImage.image = UIImage(named: "uncheck_box")
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
