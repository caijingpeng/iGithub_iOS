//
//  UIView+Utils.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

extension UIView {
    
//    public func removeAllSubviews() {
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
//    }
    
    public func drawBottomLine(_ height: CGFloat = applicationLineHeight,
                               color: UIColor = UIColor.applicationLineColor,
                               insetLeft: CGFloat = 0,
                               insetRight: CGFloat = 0) {
        
//        if let view = self.viewWithTag(1234) {
//            view.removeFromSuperview()
//        }
        
        let line = UIImageView()
        self.addSubview(line)
        
        line.tag = 1234
        line.image = imageWithColor(color)
        line.layer.masksToBounds = true
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(insetLeft)
            make.right.equalTo(self).offset(insetRight)
            make.top.equalTo(self.snp.bottom).offset(-height)
            make.height.equalTo(height)
        }
    }
    
    public func drawRightLine(_ width: CGFloat = applicationLineHeight,
                              color: UIColor = UIColor.applicationLineColor,
                              insetTop: CGFloat = 0,
                              insetBottom: CGFloat = 0) {
        
        if let view = self.viewWithTag(1235) {
            view.removeFromSuperview()
        }
        
        let line = UIImageView()
        self.addSubview(line)
        
        line.tag = 1235
        line.image = imageWithColor(color)
        line.layer.masksToBounds = true
        line.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(insetTop)
            make.bottom.equalTo(self).offset(insetBottom)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(width)
        }
    }
    
    public func drawTopLine(_ height: CGFloat = applicationLineHeight,
                            color: UIColor = UIColor.applicationLineColor,
                            insetLeft: CGFloat = 0,
                            insetRight: CGFloat = 0) {
        
//        if let view = self.viewWithTag(1236) {
//            view.removeFromSuperview()
//        }
        
        let line = UIImageView()
        self.addSubview(line)
        
        line.tag = 1236
        line.image = imageWithColor(color)
        line.layer.masksToBounds = true
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(insetLeft)
            make.right.equalTo(self).offset(insetRight)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(height)
        }
    }
}


