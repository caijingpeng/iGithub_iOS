//
//  UserLogin.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/29.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class UserLogin: NSObject {

    var userInfo: UserInfo?
    var username: String?
    var password: String?
    
    static let sharedInstance = UserLogin()
    fileprivate override init() {}
    
}

public func isLogin() -> Bool {
    return (UserLogin.sharedInstance.username != nil) ? true : false
}
