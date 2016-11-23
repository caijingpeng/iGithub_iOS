//
//  CodeBranchesView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/25.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class CodeBranchesView: BaseRefreshView {
    
    var repository: Repository?
    var datasource: [Branches]?
    var selectedBranches: ((_ branches: Branches) -> Void)?

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
        self.pagination = false
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        var param : [String: Any]? = ["owner" : (self.repository?.owner.login)!,
                                      "repo": (self.repository?.name)!]
        
        requestCodeBranches(&param, completionHandler: { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as! [Dictionary<String, Any>]? {
                self.datasource = Branches.parseArray(result)
                self.endRefreshing(true)
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        })
        
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.datasource?.count ?? 0
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: applicationWidth, height: 30))
            label.backgroundColor = UIColor.applicationLightGreyColor
            label.font = UIFont.applicationContentFont
            label.textColor = UIColor.applicationGreyColor
            label.text = "    branch"
            return label
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NormalCell
        cell.titleLabelLeading.constant = -2
        cell.iconImageView.isHidden = true
        cell.accessoryImageView.image = UIImage(named: "Accessory")
        cell.contentLabel.textColor = UIColor.applicationDarkGreyColor
        
        if (indexPath as NSIndexPath).section == 0 {
            let branch = self.datasource![(indexPath as NSIndexPath).row]
            cell.contentLabel.text = branch.name
        }
        else {
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.contentLabel.text = "Commits"
                break
            case 1:
                cell.contentLabel.text = "Branches"
                break
            case 2:
                cell.contentLabel.text = "Releases"
                break
            case 3:
                cell.contentLabel.text = "Contributer"
                break
            default:
                cell.contentLabel.text = ""
                break
            }
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath as NSIndexPath).section == 0 {
            self.selectedBranches!(self.datasource![(indexPath as NSIndexPath).row])
        }
    }

}
