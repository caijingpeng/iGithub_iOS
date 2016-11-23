//
//  OrganizationMembersRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/8.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class OrganizationMembersRefreshView: BaseRefreshView {

    var datasource: [Owner]?
    var selectedUser: ((_ user: Owner) -> Void)?
    var org: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UserInfoCell.cellHeight
        self.tableView.estimatedRowHeight = UserInfoCell.cellHeight
        self.tableView.register(UserInfoCell.self)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        if let o = org {
            var param : [String: Any]? = ["page": currentPage,
                                          "per_page": pageCount,
                                          "org": o]
            requestMembersInOrganization(&param) { (response) in
                
                guard response.error == nil else {
                    showToastInWindow(message: (response.error?.description)!)
                    return
                }
                
                if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                    
                    let followings: [Owner] = Owner.parseArray(result)
                    if self.currentPage == FirstPage {
                        self.datasource = followings
                    }
                    else {
                        self.datasource?.append(contentsOf: followings)
                    }
                    self.endRefreshing(true)
                    self.isEndPage = followings.count < self.pageCount
        
                }
                else {
                    log.error("返回数据格式错误 \(response.value)")
                }

            }
        }
        else {
            self.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = datasource?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserInfoCell
        cell.configurateInfo(self.datasource![(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedUser != nil {
            selectedUser!(datasource![(indexPath as NSIndexPath).row])
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
