//
//  UserInfoViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/2.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController {

    @IBOutlet weak var profileView: ProfileRefreshView!
    var loginName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.profileView.user = loginName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .plain, target: self, action: #selector(UserInfoViewController.toShare))
        
        self.profileView.didLoadInfo = { userInfo in
            let activity = userInfo.userActivity
            activity.isEligibleForSearch = true
            activity.isEligibleForHandoff = true
            activity.isEligibleForPublicIndexing = true
            self.userActivity = activity
        }
        
        self.profileView.headerView.infoView.selectedFollower = {
            let followerVC = FollowersViewController(nibName: "FollowersViewController", bundle: nil)
            followerVC.username = self.loginName
            self.navigationController?.pushViewController(followerVC, animated: true)
        }
        
        self.profileView.headerView.infoView.selectedStarred = {
            let starredVC = StarredViewController(nibName: "StarredViewController", bundle: nil)
            starredVC.username = self.loginName
            self.navigationController?.pushViewController(starredVC, animated: true)
        }
        
        self.profileView.headerView.infoView.selectedFollowing = {
            let followingVC = FollowingViewController(nibName: "FollowingViewController", bundle: nil)
            followingVC.username = self.loginName
            self.navigationController?.pushViewController(followingVC, animated: true)
        }
        
        self.profileView.selectedOverview = {
            
        }
        
        self.profileView.selectedRepositories = {
            let reposVC = UserRepositoryViewController(nibName: "UserRepositoryViewController", bundle: nil)
            reposVC.username = self.loginName
            self.navigationController?.pushViewController(reposVC, animated: true)
        }
        
        self.profileView.selectedActivities = {
            
            let activityVC = PublicActivitiesViewController(nibName: "PublicActivitiesViewController", bundle: nil)
            activityVC.username = self.loginName
            self.navigationController?.pushViewController(activityVC, animated: true)
        }
        
        self.profileView.selectedOrganization = { organize in
            let orgVC = OrganizationInfoViewController(nibName: "OrganizationInfoViewController", bundle: nil)
            orgVC.username = organize.login
            self.navigationController?.pushViewController(orgVC, animated: true)
        }
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        activity.addUserInfoEntries(from: (self.profileView.userInfo?.userActivityUserInfo)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = self.loginName {
            self.profileView.queryUserInfo(username)
        }
    }
    
    func toShare() {
        
        let followAction = UIAlertAction(title: "Follow", style: .default) { (action) in
            
        }
        
        let safariAction = UIAlertAction(title: "Open in Safari", style: .default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(followAction)
        actionsheet.addAction(safariAction)
        actionsheet.addAction(cancelAction)
        self.present(actionsheet, animated: true, completion: nil)
    }
    
}
