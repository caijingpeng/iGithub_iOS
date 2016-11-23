//
//  Trees.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/27.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

struct Trees: DictionaryToStruct {
    
    var sha: String
    var url: String
    var tree: [Tree]
    var truncated: Bool     // If truncated is true, the number of items in the tree array exceeded our maximum limit. If you need to fetch more items, use the non-recursive method of fetching trees, and fetch one sub-tree at a time.
    
    init(dictionary: Dictionary<String, Any>) {
        self.sha = "\(unwrap(dictionary["sha"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        self.tree = Tree.parseArray(dictionary["tree"] as! [Dictionary<String, AnyObject>])
        self.truncated = dictionary["truncated"] as! Bool
    }
}

struct Tree: Parseable, DictionaryToStruct {
    var path: String
    var mode: String
    var type: String
    var sha: String
    var size: Int
    var url: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.path = "\(unwrap(dictionary["path"]))"
        self.mode = "\(unwrap(dictionary["mode"]))"
        self.type = "\(unwrap(dictionary["type"]))"
        self.sha = "\(unwrap(dictionary["sha"]))"
        self.size = Int("\(unwrap(dictionary["sha"]))") ?? 0
        self.url = "\(unwrap(dictionary["url"]))"
    }
}










