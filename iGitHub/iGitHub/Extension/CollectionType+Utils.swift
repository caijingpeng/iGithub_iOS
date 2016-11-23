//
//  CollectionType+Utils.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

// swift 2
//extension Collection {
//    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
//    subscript (safe index: Index) -> Iterator.Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}

// swift 3

extension IndexableBase {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    public subscript(safe index: Index) -> _Element? {
        return index >= startIndex && index < endIndex
            ? self[index]
            : nil
    }
}
