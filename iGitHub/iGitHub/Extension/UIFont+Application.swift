//
//  UIFont+Application.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

extension UIFont {
    
    static var applicationGreatFont: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    static var applicationBoldGreatFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    
    static var applicationTitleFont: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static var applicationBoldTitleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static var applicationContentFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static var applicationBoldContentFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var applicationSmallFont: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
}

