//
//  StarActivity.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class StarActivity: UIActivity {
    
    var isStared: Bool = false
    var owner: String?
    var repo: String?
    var finishedBlock:(()-> Void)?
    
    override var activityImage : UIImage? {
        return UIImage(named: "Star_Big")
    }
    
    override var activityType : UIActivityType? {
        return UIActivityType(rawValue: "myacitivty")
    }
    
    override var activityTitle : String? {
        if isStared {
            return "Unstar"
        }
        else {
            return "Star"
        }
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override var activityViewController: UIViewController? {
        return nil  
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        print(activityItems)
    }
    
    override func perform() {
        
        guard let o = self.owner else { return }
        guard let r = self.repo else { return }
        
        var param : [String: Any]? = ["owner": o, "repo": r]
        
        if isStared {
            requestUnstarRepository(&param, completionHandler: { (response) in
                if response.value != nil {
                    showToastInWindow(message: "Unstared")
                    
                    if let block = self.finishedBlock {
                        block()
                    }
                    
                    self.activityDidFinish(true)
                }
                if response.error != nil {
                    showToastInWindow(message: "操作失败")
                }
            })
        }
        else {
            requestStarRepository(&param, completionHandler: { (response) in
                if response.value != nil {
                    showToastInWindow(message: "Stared")
                    
                    if let block = self.finishedBlock {
                        block()
                    }
                    
                    self.activityDidFinish(true)
                }
                if response.error != nil {
                    showToastInWindow(message: "操作失败")
                }
            })
        }
        
    }
}
