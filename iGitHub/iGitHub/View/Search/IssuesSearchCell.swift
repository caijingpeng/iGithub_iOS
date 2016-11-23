//
//  IssuesSearchCell.swift
//  iGitHub
//
//  Created by caijingpeng on 2016/10/2.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class IssuesSearchCell: BaseTableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var repoIconImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentIconImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cods
        self.titleLabel.textColor = UIColor.applicationDarkBlueColor
        self.titleLabel.font = UIFont.applicationBoldTitleFont
        
        self.numberLabel.textColor = UIColor.applicationDarkGreyColor
        self.numberLabel.font = UIFont.applicationSmallFont
        
        self.contentLabel.textColor = UIColor.applicationDarkGreyColor
        self.contentLabel.font = UIFont.applicationContentFont
        
        self.repoNameLabel.textColor = UIColor.applicationGreyColor
        self.repoNameLabel.font = UIFont.applicationSmallFont
        
        self.dateLabel.textColor = UIColor.applicationGreyColor
        self.dateLabel.font = UIFont.applicationSmallFont
        
        self.commentLabel.textColor = UIColor.applicationGreyColor
        self.commentLabel.font = UIFont.applicationSmallFont
        
    }
    
    func configurateSearchIssues(_ issue: Issue?) {
        
        self.titleLabel.text = issue?.title
        self.contentLabel.text = issue?.body
        
        if let repo = issue?.repositoryUrl.components(separatedBy: "repos/").last {
            self.repoNameLabel.text = repo
        }
        
        self.numberLabel.text = "# \(unwrap(issue?.number))"
        self.commentLabel.text = "\(unwrap(issue?.comments)) comments"
        
        if issue?.state == "open" {
            self.dateLabel.text = "Opened by \(unwrap(issue?.user?.login)) \(unwrap(issue?.createAt.prettyDateString()))"
        }
        else if issue?.state == "closed" {
            self.dateLabel.text = "Closed by \(unwrap(issue?.user?.login)) \(unwrap(issue?.closedAt.prettyDateString()))"
        }
        else {
            self.dateLabel.text = "Created by \(unwrap(issue?.user?.login)) \(unwrap(issue?.createAt.prettyDateString()))"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
