//
//  ProfileRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/27.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class ProfileRefreshView: BaseRefreshView {
    
    let headerView: ProfileView = {
        return ProfileView.instanceView()
    }()
    
    var selectedOverview: (() -> Void)?
    var selectedRepositories: (() -> Void)?
    var selectedActivities: (() -> Void)?
    var selectedOrganization: ((_ organize: Organization) -> Void)?
    var didLoadInfo: ((_ userInfo: UserInfo) -> Void)?
    
    var starredRepository: [Repository]?
    var organizations: [Organization]?
    var userInfo: UserInfo?
    var user: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pagination = false
        self.tableView.tableFooterView = UIView()
        self.tableView.register(NormalCell.self)
        self.tableView.tableHeaderView = self.headerView
    }
    
    override func awakeFromNib() {
        
    }
    
    override func updateConstraints() {
        
        headerView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(self.tableView)
//            make.height.equalTo(215)
        }
        super.updateConstraints()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        if let u = user {
            queryUserInfo(u)
        }
        else {
            self.endRefreshing()
        }
    }
    
    internal func queryUserInfo(_ user: String) {
        var param : [String: Any]? = ["user" : user]
        requestUserInfo(&param) { (response) in
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                self.userInfo = UserInfo(dictionary: result)
                
                self.headerView.headImageView.setImageWith(URL(string: (self.userInfo?.avatarUrl)!)!, placeholder: UIImage(named: "image_placeholder")) { (image, url, type, stage, error) in
                    
                    if let loadBlock = self.didLoadInfo {
                        self.userInfo?.avatar = image
                        loadBlock(self.userInfo!)
                    }
                    
                }
                
                self.headerView.configurationInfo(self.userInfo!)
                self.queryUserStarredRepository(user)
                self.queryOrganizations(user)
                
//                if let loadBlock = self.didLoadInfo {
//                    loadBlock(self.userInfo!)
//                }
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    internal func queryUserStarredRepository(_ user: String) {
        var param : [String: Any]? = ["user" : user]
        requestUserStarredRepository(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                self.starredRepository = Repository.parseArray(result)
                if let count = self.starredRepository?.count {
                    self.headerView.infoView.starredLabel.text = "\(count)"
                }
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    internal func queryOrganizations(_ user: String) {
        
        var param : [String: Any]? = ["user" : user]
        requestUserOrganization(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                self.organizations = Organization.parseArray(result)
                self.endRefreshing()
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
            
        }
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        if let orgs = self.organizations {
            return orgs.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        if self.organizations != nil && (self.organizations?.count)! > 0 {
            return 35
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let height: CGFloat = section == 0 ? 10 : 35
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: applicationWidth, height: height))
        header.backgroundColor = UIColor.applicationBackgroundColor
        
        if section == 1 {
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: applicationWidth, height: 35))
            label.textColor = UIColor.applicationGreyColor
            label.text = "Organizations"
            label.font = UIFont.applicationContentFont
            header.addSubview(label)
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NormalCell
        cell.accessoryImageView.image = UIImage(named: "Accessory")
        cell.contentLabel.textColor = UIColor.applicationDarkGreyColor
        
        if (indexPath as NSIndexPath).section == 0 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.iconImageView.image = UIImage(named: "Tab_Profile")
                cell.contentLabel.text = "Overview"
                break
            case 1:
                cell.iconImageView.image = UIImage(named: "Repository_Blue")
                cell.contentLabel.text = "Repositories"
                break
            case 2:
                cell.iconImageView.image = UIImage(named: "Public")
                cell.contentLabel.text = "Public activity"
                break
            default:
                cell.contentLabel.text = ""
                break
            }
        }
        else {
            
            let orgs = self.organizations![(indexPath as NSIndexPath).row]
            cell.iconImageView.setImageWith(URL(string: orgs.avatarUrl)!, placeholder: UIImage(named: "image_placeholder"))
            cell.contentLabel.text = orgs.login
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath as NSIndexPath).section == 0 {
            switch (indexPath as NSIndexPath).row {
            case 0:
                self.selectedOverview!()
                break
            case 1:
                self.selectedRepositories!()
                break
            case 2:
                self.selectedActivities!()
                break
            default:
                break
            }
        }
        else {
            self.selectedOrganization!(self.organizations![indexPath.row])
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
