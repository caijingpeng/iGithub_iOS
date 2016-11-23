//
//  RepositoryDetailView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/25.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class RepositoryDetailView: BaseRefreshView {
    
    var repository: Repository? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var selectedIndexPath: ((_ indexPath: IndexPath) -> Void)?

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
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NormalCell
        
        if (indexPath as NSIndexPath).section == 0 {
            cell.titleLabelLeading.constant = 4
            if (indexPath as NSIndexPath).row == 0 {
                cell.iconImageView.isHidden = true
                cell.titleLabel.text = "Owner"
                cell.contentLabel.text = self.repository?.owner.login
            }
            else if (indexPath as NSIndexPath).row == 1 {
                cell.iconImageView.isHidden = true
                cell.titleLabel.text = "Website"
                cell.contentLabel.text = self.repository?.htmlUrl
            }
        }
        else if (indexPath as NSIndexPath).section == 1 {
            if (indexPath as NSIndexPath).row == 0 {
                cell.iconImageView.isHidden = false
                cell.titleLabel.text = "Code"
                cell.iconImageView.image = UIImage(named: "Code")
            }
            else if (indexPath as NSIndexPath).row == 1 {
                cell.iconImageView.isHidden = true
                cell.titleLabel.text = "README"
                cell.titleLabelLeading.constant = 4
            }
        }
        else if (indexPath as NSIndexPath).section == 2 {
            cell.iconImageView.isHidden = false
            if (indexPath as NSIndexPath).row == 0 {
                cell.titleLabel.text = "Issues"
                cell.accessoryLabel.text = self.repository?.openIssuesCount
                cell.iconImageView.image = UIImage(named: "Issue")
            }
            else if (indexPath as NSIndexPath).row == 1 {
                cell.titleLabel.text = "Pull request"
                cell.accessoryLabel.text = "-1"
                cell.iconImageView.image = UIImage(named: "PullRequest")
            }
            else if (indexPath as NSIndexPath).row == 2 {
                cell.titleLabel.text = "Wiki"
                cell.iconImageView.image = UIImage(named: "Wiki")
            }
            else if (indexPath as NSIndexPath).row == 3 {
                cell.titleLabel.text = "Pulse"
                cell.iconImageView.image = UIImage(named: "Pulse")
            }
            else if (indexPath as NSIndexPath).row == 4 {
                cell.titleLabel.text = "Graphs"
                cell.iconImageView.image = UIImage(named: "Graph")
            }
            else if (indexPath as NSIndexPath).row == 5 {
                cell.titleLabel.text = "Settings"
                cell.iconImageView.image = UIImage(named: "Settings")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedIndexPath = self.selectedIndexPath {
            selectedIndexPath(indexPath)
        }
    }

}
