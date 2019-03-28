//
//  MainTabBarController.swift
//  TaskBase
//
//  Created by 延澤拓郎 on 2019/03/09.
//  Copyright © 2019 延澤拓郎. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var controllers = [UIViewController]()

        let myTaskMediator = MyTaskMediator()
        myTaskMediator.prepare()
        let taskListViewController = myTaskMediator.rootVC()
        controllers.append(taskListViewController)

        let searchTaskMediator = SearchTaskMediator()
        searchTaskMediator.prepare()
        let searchListViewController = searchTaskMediator.rootVC()
        controllers.append(searchListViewController)
        
        self.tabBar.barTintColor = UIColor.baseYellow()
        self.tabBar.tintColor = UIColor.textBlack()

        self.setViewControllers(
            controllers.map { UINavigationController(rootViewController: $0) },
            animated: false
        )
        self.selectedIndex = 2
        self.selectedIndex = 1
        self.selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
