//
//  OrganizationHeaderView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class OrganizationHeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var orgImageView: UIImageView!
    @IBOutlet weak var orgTitleLabel: UILabel!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    internal static func instanceView() -> OrganizationHeaderView {
        let nibview = Bundle.main.loadNibNamed("OrganizationHeaderView", owner: nil, options: nil)
        let view = nibview?.last as! OrganizationHeaderView
        view.configView()
        return view
    }
    
    fileprivate func configView() {
        
        self.orgImageView.backgroundColor = UIColor.applicationBlueColor
        
        self.orgTitleLabel.textColor = UIColor.applicationDarkGreyColor
        self.orgTitleLabel.font = UIFont.applicationBoldGreatFont
        
        self.infoTitleLabel.textColor = UIColor.applicationDarkGreyColor
        self.infoTitleLabel.font = UIFont.applicationContentFont
        
        self.urlLabel.textColor = UIColor.applicationBlueColor
        self.urlLabel.font = UIFont.applicationSmallFont
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("OrganizationHeaderView", owner: self, options: nil)
        self.addSubview(self.view)
        self.configView()
        self.view.frame = self.bounds
    }
    
    func configurateInfo(_ info: OrganizationDetail) {
        
        self.orgImageView.setImageWith(URL(string: info.avatarUrl), placeholder: UIImage(named: "image_placeholder"))
        self.orgTitleLabel.text = info.login
        self.infoTitleLabel.text = info.description.absString()
        self.urlLabel.text = info.blog
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
