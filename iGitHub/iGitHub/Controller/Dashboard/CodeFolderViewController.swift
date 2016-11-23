//
//  CodeFolderViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/19.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class CodeFolderViewController: BaseViewController {
    
    var sha: String?
    var owner: String?
    var repo: String?
    var prePath: String?
    
    @IBOutlet weak var folderView: CodeFolderRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.folderView.owner = self.owner
        self.folderView.repo = self.repo
        self.folderView.sha = self.sha
        self.folderView.beginRefreshing()
        
        self.folderView.selectedTree = { tree in
            
            var prepath: String = ""
            if self.prePath != nil {
                prepath = "\(unwrap(self.prePath))/"
            }
            let filePath = "\(prepath)\(unwrap(tree.path))"
            
            if tree.type == "tree" {
                let folderVC = CodeFolderViewController(nibName: "CodeFolderViewController", bundle: nil)
                folderVC.owner = self.owner
                folderVC.repo = self.repo
                folderVC.sha = tree.sha
                folderVC.prePath = filePath
                self.navigationController?.pushViewController(folderVC, animated: true)
            }
            else if tree.type == "blob" {
                let fileVC = CodeFileViewController()
                fileVC.owner = self.owner
                fileVC.repo = self.repo
                fileVC.filePath = filePath
                self.navigationController?.pushViewController(fileVC, animated: true)
            }
        }
    }
}
