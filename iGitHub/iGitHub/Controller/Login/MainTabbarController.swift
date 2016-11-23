//
//  MainTabbarController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    var dashboardNav: BaseNavigationController!
    var searchNav: BaseNavigationController!
    var exploreNav: BaseNavigationController!
    var profileNav: BaseNavigationController!
    
    var dashboardVC: DashboardViewController!
    var searchVC: SearchViewController!
    var exploreVC: ExploreViewController!
    var profileVC: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        dashboardNav = BaseNavigationController(rootViewController: dashboardVC)
        dashboardNav.tabBarItem.title = "Dashboard"
        dashboardNav.tabBarItem.image = UIImage(named: "Tab_Home")
        
        searchVC = SearchViewController()
        searchNav = BaseNavigationController(rootViewController: searchVC)
        searchNav.tabBarItem.title = "Search"
        searchNav.tabBarItem.image = UIImage(named: "Tab_Search")
        
        exploreVC = ExploreViewController()
        exploreNav = BaseNavigationController(rootViewController: exploreVC)
        exploreNav.tabBarItem.title = "Explore"
        exploreNav.tabBarItem.image = UIImage(named: "Tab_Github")
        
        profileVC = ProfileViewController()
        profileNav = BaseNavigationController(rootViewController: profileVC)
        profileNav.tabBarItem.title = "Profile"
        profileNav.tabBarItem.image = UIImage(named: "Tab_Profile")
        
        self.viewControllers = [dashboardNav, searchNav, exploreNav, profileNav]
        self.tabBar.tintColor = UIColor.applicationMainColor;
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
}
