//
//  CodeBranchesViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/19.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class CodeBranchesViewController: BaseViewController {
    
    var repository: Repository?
    @IBOutlet weak var branchesView: CodeBranchesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Code"
        self.branchesView.repository = repository
        self.branchesView.beginRefreshing()
        
        self.branchesView.selectedBranches = { branches in
            let folderVC: CodeFolderViewController = CodeFolderViewController(nibName: "CodeFolderViewController", bundle: nil)
            folderVC.owner = self.repository?.owner.login
            folderVC.repo = self.repository?.name
            folderVC.sha = branches.commit.sha
            self.navigationController?.pushViewController(folderVC, animated: true)
        }
    }
    
}
