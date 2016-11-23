//
//  StarInfoView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/28.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class StarInfoView: UIView {
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var starredLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet weak var followerTitleLabel: UILabel!
    @IBOutlet weak var starredTitleLabel: UILabel!
    @IBOutlet weak var followingTitleLabel: UILabel!
    
    var selectedFollower: (() -> Void)?
    var selectedStarred: (() -> Void)?
    var selectedFollowing: (() -> Void)?
    
    internal static func instanceView() -> StarInfoView {
        let nibview = Bundle.main.loadNibNamed("StarInfoView", owner: nil, options: nil)
        let view = nibview?.last as! StarInfoView
        view.configView()
        return view
    }
    
    func configView() {
        
        self.followersLabel.font = UIFont.applicationBoldGreatFont
        self.starredLabel.font = UIFont.applicationBoldGreatFont
        self.followingLabel.font = UIFont.applicationBoldGreatFont
        self.followerTitleLabel.font = UIFont.applicationSmallFont
        self.starredTitleLabel.font = UIFont.applicationSmallFont
        self.followingTitleLabel.font = UIFont.applicationSmallFont
        
        self.followersLabel.textColor = UIColor.applicationDarkBlueColor
        self.starredLabel.textColor = UIColor.applicationDarkBlueColor
        self.followingLabel.textColor = UIColor.applicationDarkBlueColor
        self.followerTitleLabel.textColor = UIColor.applicationGreyColor
        self.starredTitleLabel.textColor = UIColor.applicationGreyColor
        self.followingTitleLabel.textColor = UIColor.applicationGreyColor
        
//        self.followersLabel.text = "100"
//        self.starredLabel.text = "100k"
//        self.followingLabel.text = "1.2k"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("StarInfoView", owner: self, options: nil)
        self.addSubview(self.view)
        self.configView()
        self.view.frame = self.bounds
    }

    @IBAction func toTap(_ sender: UITapGestureRecognizer) {
        
        let tag: Int = (sender.view?.tag)!
        switch tag {
            case 1000:
                self.selectedFollower!()
                break
            case 1001:
                self.selectedStarred!()
                break
            case 1002:
                self.selectedFollowing!()
                break
            default:
                break
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
