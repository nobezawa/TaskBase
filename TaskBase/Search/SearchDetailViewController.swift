//
//  SearchDetailViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailText.numberOfLines = 0
        detailText.sizeToFit()
        detailText.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let frame = detailText.frame
        todoTableView.frame.origin.x = 0
        todoTableView.frame.origin.y = frame.origin.y + frame.size.height
        
        todoTableView.sizeToFit()
        
        let btn = UIBarButtonItem(title: "コピー", style: .plain, target: self, action: #selector(copyBtnClicked(sender:)))
        self.navigationItem.rightBarButtonItem = btn
    }
    
    @objc private func copyBtnClicked(sender: UIButton) {
        print("copy")
    }

}
