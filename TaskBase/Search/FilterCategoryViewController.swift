//
//  FilterCategoryViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/11.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

class FilterCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let categoryList = FilterCategory.list()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row].name
        return cell
    }

}
