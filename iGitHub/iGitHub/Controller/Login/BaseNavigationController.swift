//
//  BaseNavigationController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge();
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.navigationBar.setBackgroundImage(imageWithColor(UIColor.applicationBlueColor), for: .default)
        self.navigationBar.shadowImage = imageWithColor(UIColor.clear)
        self.navigationBar.isTranslucent = false;
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.backIndicatorImage = UIImage(named: "BackBarImage")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "BackBarImage")
    }
    
}
