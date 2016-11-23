//
//  MyRepositoryCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/6.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class MyRepositoryCell: BaseTableViewCell {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forkInfoLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let cellHeight: CGFloat = 60
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.forkLabel.font = UIFont.applicationSmallFont
        self.forkLabel.textColor = UIColor.applicationGreyColor
        self.starLabel.font = UIFont.applicationSmallFont
        self.starLabel.textColor = UIColor.applicationGreyColor
        self.languageLabel.font = UIFont.applicationSmallFont
        self.languageLabel.textColor = UIColor.applicationGreyColor
        
        self.repositoryNameLabel.font = UIFont.applicationBoldTitleFont
        self.repositoryNameLabel.textColor = UIColor.applicationBlueColor
        
        self.forkInfoLabel.font = UIFont.applicationSmallFont
        self.forkInfoLabel.textColor = UIColor.applicationGreyColor
        
        self.discriptionLabel.font = UIFont.applicationContentFont
        self.discriptionLabel.textColor = UIColor.applicationDarkGreyColor
        
        self.dateLabel.font = UIFont.applicationSmallFont
        self.dateLabel.textColor = UIColor.applicationGreyColor
    }
    
    func configurateRepository(_ repository: Repository?) {
        if repository != nil {
            if let isFork = repository?.fork {
                self.forkInfoLabel.isHidden = !isFork
                self.forkInfoLabel.text = "forked from "
            }
            self.discriptionLabel.text = repository?.description.absString()
            self.discriptionLabel.isHidden = (repository?.description.isLengthZero())!
            if let updateAt = repository?.updatedAt {
                self.dateLabel.text = "Update on \(updateAt.prettyDateString())"
            }
            else {
                self.dateLabel.text = ""
            }
            self.repositoryNameLabel.text = repository!.fullName
            self.forkLabel.text = repository!.forksCount
            self.starLabel.text = repository!.stargazersCount
            self.languageLabel.text = repository?.language.absString()
        }
    }
    
}
