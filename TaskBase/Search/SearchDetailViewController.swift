//
//  SearchDetailViewController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/12.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var todoTableView: UITableView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailText.numberOfLines = 0
        detailText.sizeToFit()
        detailText.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let frame = detailText.frame
        todoTableView.frame.origin.x = 0
        todoTableView.frame.origin.y = frame.origin.y + frame.size.height
        
        todoTableView.sizeToFit()
        
        let copyBtn = UIBarButtonItem(title: "コピー", style: .plain, target: nil, action: nil)
        copyBtn.rx.tap
            .subscribe(onNext: { _ in
                let viewModel = SearchDetailViewModel()
                //viewModel.cloneTask()
                //viewModel.selectTask()
                print("click copy");
            })
            .disposed(by: disposeBag)

        self.navigationItem.rightBarButtonItem = copyBtn
        
        let backBtn = UIBarButtonItem()
        backBtn.title = ""
        self.navigationItem.backBarButtonItem = backBtn
    }
}
