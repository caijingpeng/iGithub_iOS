//
//  FollowingViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/1.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class FollowingViewController: BaseViewController {

    @IBOutlet weak var followingView: FollowingRefreshView!
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Followering"
        self.followingView.username = username;
        self.followingView.beginRefreshing()
        
        self.followingView.selectedUser = { user in
            let userVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
            userVC.loginName = user.login
            self.navigationController?.pushViewController(userVC, animated: true)
        }
        // Do any additional setup after loading the view.
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
