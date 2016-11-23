//
//  DashboardViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var repositoryView: MyRepositoryRefreshView!
    @IBOutlet weak var newsView: BaseRefreshView!
    @IBOutlet weak var activityView: MyActivitiesRefreshView!
    @IBOutlet weak var segmentCtrl: AnimateSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Dashboard"
        self.segmentCtrl.bindScrollView = self.mainScrollView
        self.segmentCtrl.titleArray = ["Repositories", "Activities", "News"]
        self.segmentCtrl.drawBottomLine()
        
        repositoryView.selectedRepository = { repository in
            let detail = RepositoryDetailViewController(nibName: "RepositoryDetailViewController", bundle: nil)
            detail.hidesBottomBarWhenPushed = true;
            detail.repository = repository
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        if isLogin() {
            self.repositoryView.beginRefreshing()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessNotification), name: NSNotification.Name(rawValue: "LoginSuccessNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loginSuccessNotification() {
        self.repositoryView.beginRefreshing()
        self.activityView.beginRefreshing()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}
