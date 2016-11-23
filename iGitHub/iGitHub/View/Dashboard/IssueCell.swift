//
//  IssueCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var commentNumberLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.titleLabel.textColor = UIColor.applicationDarkGreyColor
        self.titleLabel.font = UIFont.applicationBoldTitleFont
        
        self.subTitleLabel.textColor = UIColor.applicationGreyColor
        self.subTitleLabel.font = UIFont.applicationContentFont
        
        self.commentNumberLabel.textColor = UIColor.applicationGreyColor
        self.commentNumberLabel.font = UIFont.applicationContentFont
    }
    
    func configurateIssue(_ issue: Issue) {
        
        if issue.state == "closed" {
            self.iconImageView.image = UIImage(named: "Issue")
            self.subTitleLabel.text = "#\(issue.number) by \(unwrap(issue.user!.login)) was \(issue.state) \(issue.closedAt)"
        }
        else if issue.state == "open" {
            self.iconImageView.image = UIImage(named: "Issue")
            self.subTitleLabel.text = "#\(issue.number) by \(unwrap(issue.user!.login)) was \(issue.state) \(issue.createAt)"
        }
        
        self.titleLabel.text = issue.title
        self.commentNumberLabel.text = "\(unwrap(issue.comments))"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
