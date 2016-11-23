//
//  CodeFolderRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/27.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class CodeFolderRefreshView: BaseRefreshView {
    
    var sha: String?
    var owner: String?
    var repo: String?
    var datasource: Trees?
    
    var selectedTree: ((_ tree: Tree) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.tableFooterView = UIView()
        self.tableView.register(NormalCell.self)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        var param : [String: Any]? = ["owner" : owner!,
                                      "repo": repo!,
                                      "sha": sha!]
        
        requestFileTree(&param, completionHandler: { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                self.datasource = Trees(dictionary: result)
                self.endRefreshing()
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.datasource?.tree.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NormalCell
        let tree = self.datasource?.tree[(indexPath as NSIndexPath).row]
        if tree?.type == "tree" {
            cell.iconImageView.image = UIImage(named: "Folder")
            cell.contentLabel.text = tree?.path
        }
        else if tree?.type == "blob" {
            cell.iconImageView.image = UIImage(named: "File")
            cell.contentLabel.text = tree?.path
        }
        else {
            cell.iconImageView.image = UIImage(named: "")
            cell.contentLabel.text = "\(tree?.path) + \(tree?.type)"
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedTree!((self.datasource?.tree[(indexPath as NSIndexPath).row])!)
    }

}
