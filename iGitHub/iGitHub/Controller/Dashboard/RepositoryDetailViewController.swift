//
//  RepositoryDetailViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import Social

class RepositoryDetailViewController: BaseViewController {

    var repository: Repository?
    var url: String?
    var isStar: Bool = false
    
    @IBOutlet weak var detailView: RepositoryDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if repository != nil {
            
            self.fillData()
        }
        else {
            self.queryDetail()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.queryIsStar()
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        activity.addUserInfoEntries(from: (repository?.userActivityUserInfo)!)
    }
    
    private func queryDetail() {
        requestRepositoryDetailByUrl(urlString: self.url) { (response) in
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as! Dictionary<String, Any>? {
                
                self.repository = Repository(dictionary: result)
                self.queryIsStar()
                self.fillData()
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    private func queryIsStar() {
        guard let o = self.repository?.owner.login else { return }
        guard let r = self.repository?.name else { return }
        
        var param : [String: Any]? = ["owner": o, "repo": r]
        requestIsStarRepository(&param, completionHandler: { (response) in
            if response.value != nil {
                self.isStar = true
            }
            if response.error != nil {
                self.isStar = false
            }
        })
    }
    
    private func fillData() {
        
        guard repository != nil else { return }
        
        let activity = repository?.userActivity
        activity?.isEligibleForSearch = true
        activity?.isEligibleForHandoff = true
        activity?.isEligibleForPublicIndexing = true
        userActivity = activity
        
        self.navigationItem.title = repository?.name
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .plain, target: self, action: #selector(RepositoryDetailViewController.toShare))
        
        self.detailView.repository = self.repository
        
        self.detailView.selectedIndexPath = { indexPath in
            
            if (indexPath as NSIndexPath).section == 0 {
                if (indexPath as NSIndexPath).row == 0 {
                    
                    if self.repository?.owner.type == .organization {
                        let orgVC = OrganizationInfoViewController(nibName: "OrganizationInfoViewController", bundle: nil)
                        orgVC.hidesBottomBarWhenPushed = true
                        orgVC.username = self.repository?.owner.login
                        self.navigationController?.pushViewController(orgVC, animated: true)
                    }
                    else if self.repository?.owner.type == .user {
                        let userVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
                        userVC.loginName = self.repository?.owner.login
                        self.navigationController?.pushViewController(userVC, animated: true)
                    }
                    
                }
                else if (indexPath as NSIndexPath).row == 1 {
                    let web = WebBrowserViewController(nibName: "WebBrowserViewController", bundle: nil)
                    web.htmlUrl = self.repository?.htmlUrl
                    self.navigationController?.pushViewController(web, animated: true)
                }
            }
            else if (indexPath as NSIndexPath).section == 1 {
                if (indexPath as NSIndexPath).row == 0 {
                    let codeVC = CodeBranchesViewController()
                    codeVC.repository = self.repository
                    self.navigationController?.pushViewController(codeVC, animated: true)
                }
                else if (indexPath as NSIndexPath).row == 1 {
                    let fileVC = CodeFileViewController()
                    fileVC.owner = self.repository?.owner.login
                    fileVC.repo = self.repository?.name
                    fileVC.isReadMe = true
                    self.navigationController?.pushViewController(fileVC, animated: true)
                }
            }
            else if (indexPath as NSIndexPath).section == 2 {
                if (indexPath as NSIndexPath).row == 0 {
                    let issueVC = IssueListViewController(nibName: "IssueListViewController", bundle: nil)
                    issueVC.username = self.repository?.owner.login
                    issueVC.repositoryName = self.repository?.name
                    self.navigationController?.pushViewController(issueVC, animated: true)
                    
                }
                else if (indexPath as NSIndexPath).row == 1 {
                }
                else if (indexPath as NSIndexPath).row == 2 {
                }
                else if (indexPath as NSIndexPath).row == 3 {
                }
                else if (indexPath as NSIndexPath).row == 4 {
                }
                else if (indexPath as NSIndexPath).row == 5 {
                }
            }
            
        }
    }
    
    func toShare() {
        
        let excludedActivities = [UIActivityType.assignToContact,
                                  UIActivityType.saveToCameraRoll];
        let starActivity = StarActivity()
        starActivity.owner = self.repository?.owner.login
        starActivity.repo = self.repository?.name
        starActivity.isStared = self.isStar
        starActivity.finishedBlock = {
            self.queryIsStar()
        }
        
        let shareObj = URL(string: (self.repository?.htmlUrl)!)
        
        let controller = UIActivityViewController(activityItems: [shareObj!], applicationActivities: [starActivity])
        controller.excludedActivityTypes = excludedActivities;
        self.present(controller, animated: true, completion: nil)
        
//        controller.completionWithItemsHandler = { (type, complete, item, error) in
//            print("\(type) \(complete) \(item) \(error)")
//        }
        
        /*
        let starAction = UIAlertAction(title: "Star", style: .Default) { (action) in
            
        }
        
        let safariAction = UIAlertAction(title: "Open in Safari", style: .Default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        actionsheet.addAction(starAction)
        actionsheet.addAction(safariAction)
        actionsheet.addAction(cancelAction)
        self.presentViewController(actionsheet, animated: true, completion: nil)
 */
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
