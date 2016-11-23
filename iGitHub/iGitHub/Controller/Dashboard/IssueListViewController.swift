//
//  IssueListViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class IssueListViewController: BaseViewController {

    @IBOutlet weak var issueRefreshView: IssueListRefreshView!
    var username: String?
    var repositoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Issue"
        
        self.issueRefreshView.username = self.username
        self.issueRefreshView.repositoryName = self.repositoryName
        self.issueRefreshView.beginRefreshing()
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
