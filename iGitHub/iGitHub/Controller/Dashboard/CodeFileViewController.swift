//
//  CodeFileViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class CodeFileViewController: BaseViewController {

    var sha         : String?
    var owner       : String?
    var repo        : String?
    var isReadMe    : Bool?
    var filePath    : String?
    
    @IBOutlet weak var fileWebview: UIWebView!
    var fileInfo: File?
    
    override func viewDidLoad() {
        
        if isReadMe == true {
            loadReadMe()
        }
        else {
            loadFile()
        }
    }
    
    func loadReadMe() {
        var param : [String: Any]? = ["owner" : self.owner!,
                                            "repo": self.repo!]
        requestRepositoryReadme(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                
                self.fileInfo = File(dictionary: result)
                self.navigationItem.title = self.fileInfo?.name
                
                if let url = self.fileInfo?.downloadUrl {
                    self.fileWebview.loadMarkdownByRawUrl(url)
                }
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    func loadFile() {
        var param : [String: Any]? = ["owner" : self.owner!,
                                            "repo": self.repo!,
                                            "path": (self.filePath)!]
        
        requestFileContent(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                
                self.fileInfo = File(dictionary: result)
                self.navigationItem.title = self.fileInfo?.name
                
                if let url = self.fileInfo?.downloadUrl {
                    
                    let ext = url.components(separatedBy: ".").last
                    if ext == "md" {
                        self.fileWebview.loadMarkdownByRawUrl(url)
                    }
                    else {
                        self.fileWebview.loadCodeFileByRawUrl(url)
                    }
                }
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
            
            
            
        }
    }
    
}
