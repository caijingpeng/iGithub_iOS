//
//  ParseStruct.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/25.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

protocol DictionaryToStruct {
    init(dictionary: Dictionary<String, Any>)
}

protocol Parseable {
    static func parseArray(_ array: [Dictionary<String, Any>]) -> [Self]
}

extension Parseable {
    static func parseArray<T: DictionaryToStruct> (_ array: [Dictionary<String, Any>]) -> [T] {
        
        let results: [T] = array.map({ dictionary -> T in
            let rep = T(dictionary: dictionary)
            return rep
        })
        
        return results
    }
}
