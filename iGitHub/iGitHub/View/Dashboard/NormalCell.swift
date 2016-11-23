//
//  NormalCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class NormalCell: BaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var accessoryLabel: UILabel!
    
    @IBOutlet weak var titleLabelLeading: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.titleLabel.font = UIFont.applicationTitleFont
        self.contentLabel.font = UIFont.applicationTitleFont
        
        self.accessoryLabel.font = UIFont.applicationContentFont
        self.accessoryLabel.textColor = UIColor.applicationDarkGreyColor
        
        self.titleLabel.textColor = UIColor.applicationLightBlueColor
        self.contentLabel.textColor = UIColor.applicationBlueColor
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
