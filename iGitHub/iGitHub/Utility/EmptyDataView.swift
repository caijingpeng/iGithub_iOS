//
//  EmptyDataView.swift
//  iGitHub
//
//  Created by caijingpeng on 2016/10/8.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class EmptyDataView: UIView {
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var indicatorLabel: UILabel!
    internal static func instanceView() -> EmptyDataView {
        let nibview = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)
        let view = nibview?.last as! EmptyDataView
        view.configView()
        return view
    }
    
    fileprivate func configView() {
        
        self.indicatorLabel.font = UIFont.applicationGreatFont
        self.indicatorLabel.textColor = UIColor.applicationGreyColor
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
