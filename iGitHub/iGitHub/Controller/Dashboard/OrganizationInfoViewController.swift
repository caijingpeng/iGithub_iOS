//
//  OrganizationInfoViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class OrganizationInfoViewController: BaseViewController {

    @IBOutlet weak var headerView: OrganizationHeaderView!
    @IBOutlet weak var segmentCtrl: AnimateSegmentControl!
    @IBOutlet weak var mainSV: UIScrollView!
    var username: String?
    var organize: OrganizationDetail?
    @IBOutlet weak var repositoryView: OrganizationRepositoryRefreshView!
    
    @IBOutlet weak var membersView: OrganizationMembersRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Organization"
        
        self.headerView.drawBottomLine()
        self.segmentCtrl.bindScrollView = self.mainSV
        self.segmentCtrl.titleArray = ["Repositories", "People(-1)"]
        self.segmentCtrl.drawBottomLine()
        
        self.repositoryView.org = self.username
        self.membersView.org = self.username
        
        self.repositoryView.selectedRepository = { repository in
            let detail = RepositoryDetailViewController(nibName: "RepositoryDetailViewController", bundle: nil)
            detail.repository = repository
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        self.membersView.selectedUser = { user in
            let userVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
            userVC.loginName = user.login
            self.navigationController?.pushViewController(userVC, animated: true)
        }
        
//        if let org = self.org {
//            self.headerView.configurateInfo(org)
//        }
        self.queryOrganizationDetail()
    }
    
    func queryOrganizationDetail() {
        
        var param : [String: Any]? = ["org": self.username!]
        
        requestOrganizationDetail(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                self.organize = OrganizationDetail(dictionary: result)
                self.headerView.configurateInfo(self.organize!)
                self.repositoryView.beginRefreshing()
                self.membersView.beginRefreshing()
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
