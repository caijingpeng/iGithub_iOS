//
//  ProfileViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileView: ProfileRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        
        self.profileView.headerView.infoView.selectedFollower = {
            let followerVC = FollowersViewController(nibName: "FollowersViewController", bundle: nil)
            followerVC.hidesBottomBarWhenPushed = true
            followerVC.username = UserLogin.sharedInstance.username
            self.navigationController?.pushViewController(followerVC, animated: true)
        }
        
        self.profileView.headerView.infoView.selectedStarred = {
            let starredVC = StarredViewController(nibName: "StarredViewController", bundle: nil)
            starredVC.hidesBottomBarWhenPushed = true
            starredVC.username = UserLogin.sharedInstance.username
            self.navigationController?.pushViewController(starredVC, animated: true)
        }
        
        self.profileView.headerView.infoView.selectedFollowing = {
            let followingVC = FollowingViewController(nibName: "FollowingViewController", bundle: nil)
            followingVC.hidesBottomBarWhenPushed = true
            followingVC.username = UserLogin.sharedInstance.username
            self.navigationController?.pushViewController(followingVC, animated: true)
        }
        
        self.profileView.selectedOverview = {
            
        }
        
        self.profileView.selectedRepositories = {
            let reposVC = UserRepositoryViewController(nibName: "UserRepositoryViewController", bundle: nil)
            reposVC.hidesBottomBarWhenPushed = true
            reposVC.username = UserLogin.sharedInstance.username
            self.navigationController?.pushViewController(reposVC, animated: true)
        }
        
        self.profileView.selectedActivities = {
            let activityVC = PublicActivitiesViewController(nibName: "PublicActivitiesViewController", bundle: nil)
            activityVC.hidesBottomBarWhenPushed = true
            activityVC.username = UserLogin.sharedInstance.username
            self.navigationController?.pushViewController(activityVC, animated: true)
        }
        
        self.profileView.selectedOrganization = { organize in
            
            let orgVC = OrganizationInfoViewController(nibName: "OrganizationInfoViewController", bundle: nil)
            orgVC.hidesBottomBarWhenPushed = true
            orgVC.username = organize.login
            self.navigationController?.pushViewController(orgVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = UserLogin.sharedInstance.username {
            self.profileView.queryUserInfo(username)
        }
    }

}
