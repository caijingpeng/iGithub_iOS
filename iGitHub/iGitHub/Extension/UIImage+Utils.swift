//
//  UIImage+Utils.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/6.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

public func imageWithColor(_ color: UIColor) -> UIImage {
    let size = CGSize(width: 1, height: 1)
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    context?.setFillColor(color.cgColor);
    context?.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!;
}
