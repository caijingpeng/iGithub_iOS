//
//  String+Utils.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/2.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

extension String {
    
    func isLengthZero() -> Bool {
        if self == "" || self == "<null>" {
            return true
        }
        return false
    }
    
    func absString() -> String {
        if self == "<null>" {
            return ""
        }
        return self
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[(startIndex ..< endIndex)]
        }
    }
    
    func toDate() -> Date {
        var time = tm()
        strptime(self.cString(using: String.Encoding.utf8)!, "%Y-%M-%dT%H:%M:%S%z", &time)
        time.tm_isdst = -1
        let t = mktime(&time)
        return Date.init(timeIntervalSince1970: Double(t + NSTimeZone.local.secondsFromGMT()))
    }
    
}
