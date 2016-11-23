//
//  UIColor+Application.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

extension UIColor {
    
    static var applicationBackgroundColor: UIColor {
        return UIColor("#EDEDED")
    }
    
    static var applicationMainColor: UIColor {
        return applicationBlueColor
    }
    
    static var applicationRedColor: UIColor {
        return UIColor("#F44335")
    }
    
    static var applicationYellowColor: UIColor {
        return UIColor("#F5B407")
    }
    
    static var applicationDarkBlueColor: UIColor {
        return UIColor("#3646A8")
    }
    
    static var applicationBlueColor: UIColor {
        return UIColor("#3B51B5")
    }
    
    static var applicationLightBlueColor: UIColor {
        return UIColor("#7985CB")
    }
    
    static var applicationDarkGreyColor: UIColor {
        return UIColor("#000000")
        
    }
    
    static var applicationGreyColor: UIColor {
        return UIColor("#6D6D6D")
    }
    
    static var applicationLightGreyColor: UIColor {
        return UIColor("#F8F8F8")
    }
    
    static var applicationLineColor: UIColor {
        return UIColor("#E0E0E0")
    }
    
    static var applicationLightCyanColor: UIColor {
        return UIColor("#E8F1F6")
    }
}

var applicationLineHeight: CGFloat {
    return 1 / UIScreen.main.scale
}

var applicationWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

var applicationHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

var applicationHeightNoNavigation: CGFloat {
    return UIScreen.main.bounds.size.height - 64
}
