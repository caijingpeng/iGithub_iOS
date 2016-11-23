//
//  SearchResult.swift
//  iGitHub
//
//  Created by caijingpeng on 2016/9/30.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

struct SearchResult<T: Parseable>: DictionaryToStruct {
    
    var total_count: Int
    var incomplete_results: Bool
    var items: [T]
    
    init(dictionary: Dictionary<String, Any>) {
        self.total_count = Int("\(unwrap(dictionary["total_count"]))") ?? 0
        self.incomplete_results = dictionary["incomplete_results"] as! Bool
        
        if let array: [Dictionary<String, Any>] = dictionary["items"] as? [Dictionary<String, Any>] {
            self.items = T.parseArray(array)
        }
        else {
            items = []
        }
    }
}
