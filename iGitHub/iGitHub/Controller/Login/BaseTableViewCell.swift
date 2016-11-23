//
//  BaseTableViewCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/6.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
