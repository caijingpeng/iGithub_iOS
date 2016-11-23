//
//  IssueListRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class IssueListRefreshView: BaseRefreshView {

    var datasource: Array<Issue>?
    var selectedIssue: ((_ issue: Issue) -> Void)?
    var username: String?
    var repositoryName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(IssueCell.self)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        var param : [String: Any]? = ["user": self.username!, "repo": self.repositoryName!]
        
        requestIssueInRepository(&param) { (response) in
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                
                let infoArray: [Issue] = Issue.parseArray(result)
                if self.currentPage == FirstPage {
                    self.datasource = infoArray
                }
                else {
                    self.datasource?.append(contentsOf: infoArray)
                }
                self.endRefreshing(true)
                self.isEndPage = infoArray.count < self.pageCount
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = datasource?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as IssueCell
        cell.configurateIssue(datasource![(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIssue != nil {
            selectedIssue!(datasource![(indexPath as NSIndexPath).row])
        }
    }

}
