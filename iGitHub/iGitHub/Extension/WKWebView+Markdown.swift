//
//  WKWebView+Markdown.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/18.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import WebKit

let languageMap: Dictionary<String, String> = ["rb": "Ruby",
                                               "css": "css",
                                               "m": "objectivec",
                                               "h": "objectivec",
                                               "cpp": "cpp",
                                               "py": "python"]

public func getLanguageByExtension(_ url: String) -> String {
    let ext = url.components(separatedBy: ".").last
    return languageMap[ext!] ?? "c"
}

extension UIWebView {
    
    func formatMarkdownHtml(_ raw: String) -> String? {
        let path = Bundle.main.path(forResource: "Markdown Editor", ofType: "html")
        
        var template: String?
        do {
            template = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
        let result = template!.replacingOccurrences(of: "# Markdown Editor", with: raw)
        
        return result
    }
    
    func formatCodeFileHtml(_ raw: String, url: String) -> String? {
        let path = Bundle.main.path(forResource: "FileParse", ofType: "html")
        
        var template: String?
        do {
            template = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
        let code = template!.replacingOccurrences(of: "#code#", with: raw)
        let result = code.replacingOccurrences(of: "#language#", with: getLanguageByExtension(url))
        
        return result
    }
    
    public func loadMarkdownByRawUrl(_ url: String) {
        
        requestFileRaw(url) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Data = response.value as? Data {
                
                let rawString = String(data: result, encoding: String.Encoding.utf8)
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                
                if let htmlStr = self.formatMarkdownHtml(rawString!) {
                    self.loadHTMLString(htmlStr, baseURL: baseURL)
                }
                
//                https://developer.github.com/v3/markdown/
                
//                requestMarkDown(rawString!, completionHandler: { (response) in
//                    if let htmlStr = response.value {
//                        self.loadHTMLString(htmlStr as! String, baseURL: nil)
//                    }
//                })
                
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
            
            
        }
    }
    
    public func loadCodeFileByRawUrl(_ url: String) {
        
        requestFileRaw(url) { (response) in
           
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Data = response.value as? Data {
                
                let rawString = String(data: result, encoding: String.Encoding.utf8)
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                
                if let htmlStr = self.formatCodeFileHtml(rawString!, url: url) {
                    self.loadHTMLString(htmlStr, baseURL: baseURL)
                }
                
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
}
