//
//  ProfileView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/25.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileView: UIView {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoView: StarInfoView!
    @IBOutlet weak var bioLabel: UILabel!
    
    internal static func instanceView() -> ProfileView {
        let nibview = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)
        let view = nibview?.last as! ProfileView
        view.configView()
        return view
    }
    
    fileprivate func configView() {
                
        self.nameLabel.font = UIFont.applicationGreatFont
        self.nickname.font = UIFont.applicationTitleFont
        self.companyLabel.font = UIFont.applicationSmallFont
        self.locationLabel.font = UIFont.applicationSmallFont
        self.emailLabel.font = UIFont.applicationSmallFont
        self.timeLabel.font = UIFont.applicationSmallFont
        self.bioLabel.font = UIFont.applicationTitleFont
        
        self.nameLabel.textColor = UIColor.applicationDarkBlueColor
        self.nickname.textColor = UIColor.applicationLightBlueColor
        self.companyLabel.textColor = UIColor.applicationDarkGreyColor
        self.locationLabel.textColor = UIColor.applicationDarkGreyColor
        self.emailLabel.textColor = UIColor.applicationDarkGreyColor
        self.timeLabel.textColor = UIColor.applicationDarkGreyColor
        self.bioLabel.textColor = UIColor.applicationDarkGreyColor
        
//        self.nameLabel.text = "caijingpeng"
//        self.nickname.text = "caijingpeng"
//        self.companyLabel.text = "Google.Inc"
//        self.locationLabel.text = "Beijing"
//        self.emailLabel.text = "developer418@163.com"
//        self.timeLabel.text = "Joined on May 23, 2012"
    }
    
    internal func configurationInfo(_ info: UserInfo) {
        
        self.nameLabel.text = info.name
        self.nickname.text = info.login
        self.companyLabel.text = info.company
        self.locationLabel.text = info.location
        self.emailLabel.text = info.email
        self.timeLabel.text = info.createdAt.prettyDateString()
        self.bioLabel.text = info.bio.absString()
//        self.bioLabel.text = "sdfsdsfasfdsdfasdfasdfasdfafasdgdfgkldjflkajfksjfl;skjdfl;kdjfaosifdjasldfkjldfksadfoisjdofisaldfksldfkjsaidfoaskfosakfdaslfasljfdk"
        
        self.infoView.followersLabel.text = info.followers
        self.infoView.followingLabel.text = info.following
        
        self.infoView.drawBottomLine()
        self.infoView.drawTopLine()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
