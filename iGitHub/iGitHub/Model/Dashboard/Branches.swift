//
//  Branches.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/25.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

/*
 {
 commit =         {
 sha = e1989003f9b882a92a0e668070355642c2806543;
 url = "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/commits/e1989003f9b882a92a0e668070355642c2806543";
 };
 name = master;
 }
 */

struct Branches: Parseable, DictionaryToStruct {
    var commit: Commit
    var name: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.name = "\(unwrap(dictionary["name"]))"
        self.commit = Commit(dictionary: dictionary["commit"] as! Dictionary)
    }
}

struct Commit: DictionaryToStruct, Parseable {
    var sha: String
    var url: String
    var author: Author?
    var message: String?
    var distinct: Bool?
    
    init(dictionary: Dictionary<String, Any>) {
        self.sha = "\(unwrap(dictionary["sha"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        
        if let dic = dictionary["author"] as? Dictionary<String, AnyObject> {
            self.author = Author(dictionary: dic)
        }
        self.sha = "\(unwrap(dictionary["sha"]))"
        
        if let dis = dictionary["distinct"] as? Bool {
            self.distinct = dis
        }
        self.message = "\(unwrap(dictionary["message"]))"
    }
}

struct Author: DictionaryToStruct {
    var name: String
    var email: String
    init(dictionary: Dictionary<String, Any>) {
        self.name = "\(unwrap(dictionary["name"]))"
        self.email = "\(unwrap(dictionary["email"]))"
    }
}





