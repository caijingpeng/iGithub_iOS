//
//  UserInfoCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/1.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class UserInfoCell: BaseTableViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    
    static let cellHeight: CGFloat = 70
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.nameLabel.font = UIFont.applicationTitleFont
        
        self.nameLabel.textColor = UIColor.applicationDarkGreyColor
        
//        self.followButton.layer.borderColor = UIColor.applicationLineColor.CGColor
//        self.followButton.layer.borderWidth = applicationLineHeight
//        self.followButton.layer.cornerRadius = 5
//        self.followButton.clipsToBounds = true
//        self.followButton.titleLabel?.font = UIFont.applicationContentFont
        self.followButton.isHidden = true
    }

    func configurateInfo(_ info: Owner) -> Void {
        
        self.headImageView.setImageWith(URL(string: info.avatarUrl)!, placeholder: UIImage(named: "image_placeholder"))
        self.nameLabel.text = info.login
        
//        if !info.company.isLengthZero() {
//            self.contentLabel.text = info.company
//            self.iconImageView.image = UIImage(named: "Company")
//        }
//        else if !info.location.isLengthZero() {
//            self.contentLabel.text = info.location
//            self.iconImageView.image = UIImage(named: "Location")
//        }
//        else if !info.email.isLengthZero() {
//            self.contentLabel.text = info.email
//            self.iconImageView.image = UIImage(named: "Email")
//        }
//        else {
//            self.contentLabel.text = nil
//            self.iconImageView.image = nil
//        }
        
//        if let isFollow = info.isFollow {
//            self.followButton.isHidden = false
//            if isFollow {
//                self.followButton.setBackgroundImage(imageWithColor(UIColor.white), for: UIControlState())
//                self.followButton.setTitle("Unfollow", for: UIControlState())
//                self.followButton.setTitleColor(UIColor.darkGray, for: UIControlState())
//            }
//            else {
//                self.followButton.setBackgroundImage(imageWithColor(UIColor.applicationBlueColor), for: UIControlState())
//                self.followButton.setTitle("Follow", for: UIControlState())
//                self.followButton.setTitleColor(UIColor.white, for: UIControlState())
//            }
//        }
//        else {
//            self.followButton.isHidden = true
//        }
        
    }
}
