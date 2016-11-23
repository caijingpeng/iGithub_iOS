//
//  StarredRepositoryCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/3.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class StarredRepositoryCell: BaseTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.nameLabel.textColor = UIColor.applicationBlueColor
        self.nameLabel.font = UIFont.applicationBoldTitleFont
        
        self.infoLabel.textColor = UIColor.applicationDarkGreyColor
        self.infoLabel.font = UIFont.applicationContentFont
        
        self.dateLabel.textColor = UIColor.applicationGreyColor
        self.dateLabel.font = UIFont.applicationSmallFont
        
    }
    
    func configurateRepository(_ repository: Repository?) {
        if repository != nil {
            
            self.nameLabel.text = repository!.fullName
            self.infoLabel.text = repository!.description.absString()
            self.infoLabel.isHidden = (self.infoLabel.text?.isLengthZero())!
            
            self.dateLabel.text = repository?.createdAt.prettyDateString()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
