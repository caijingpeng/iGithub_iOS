//
//  Utility.swift
//  iGitHub
//
//  Created by caijingpeng on 2016/9/29.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

// ------ Toast ------

func showToastInWindow(message: String) {
    appDelegate.window?.makeToast(message)
}

func showToastInWindow(message: String, image: UIImage) {
    appDelegate.window?.makeToast("This is a piece of toast with an image",
                                  duration: 2.0,
                                  position: .center,
                                  title: nil,
                                  image: UIImage(named: "toast.png"),
                                  style: nil,
                                  completion: nil)
}

func showToastActivity() {
    appDelegate.window?.makeToastActivity(.center)
}

func hideToastActivity() {
    appDelegate.window?.hideToastActivity()
}

// ------ Check ---------

func checkValue(value: Any?, message: String? = nil) -> Bool {
    
    guard (value is String && !(value as! String).isLengthZero()) || (!(value is String) && value != nil) else {
        if let msg = message {
            showToastInWindow(message: msg)
        }
        return false
    }
    
    return true
}




