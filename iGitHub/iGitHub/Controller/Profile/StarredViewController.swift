//
//  StarredViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/1.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class StarredViewController: BaseViewController {

    @IBOutlet weak var starredView: StarredRefreshView!
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Starred"
        self.starredView.username = username
        self.starredView.beginRefreshing()
        
        self.starredView.selectedRepository = { repository in
            let detail = RepositoryDetailViewController(nibName: "RepositoryDetailViewController", bundle: nil)
            detail.hidesBottomBarWhenPushed = true;
            detail.repository = repository
            self.navigationController?.pushViewController(detail, animated: true)
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
