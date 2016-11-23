//
//  AnimateSegmentControl.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import SnapKit

class AnimateSegmentControl: UIView {
    
    let inactiveColor = UIColor.applicationGreyColor
    let activeColor = UIColor.applicationBlueColor
    
    var indicatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleArray: [String]? {
        didSet {
            self.installButtons()
        }
    }
    
    fileprivate var tempIndex: CGFloat = 0
    
    var selectedIndex: Int {
        get {
            return Int(self.indicatorView.frame.minX / self.indicatorView.frame.width)
        }
        set (newValue) {
            tempIndex = CGFloat(newValue)
            self.refreshLayout(self.frame.width)
        }
        
    }
    
    var bindScrollView: UIScrollView? {
        didSet {
            if bindScrollView != nil {
                bindScrollView!.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        bindScrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func awakeFromNib() {
        
        self.backgroundColor = UIColor.white
//        self.addSubview(self.containerView)
        self.addSubview(self.indicatorView)
        
        self.indicatorView.backgroundColor = activeColor
        
//        self.containerView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 3, 0))
//        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadButtonColor()
    }
    
    func toSelect(_ sender: UIButton) {
        let index = sender.tag - 1000
        UIView.animate(withDuration: 0.3, animations: {
            self.selectedIndex = index
        }) 
    }
    
    internal func refreshLayout(_ width: CGFloat) {
        if let scrollview = self.bindScrollView {
            scrollview.contentOffset = CGPoint(x: width * CGFloat(tempIndex), y: 0)
        }
        self.indicatorView.snp.updateConstraints({ (make) in
            make.left.equalTo(CGFloat(tempIndex) * (self.indicatorView.frame).width)
        })
    }
    
    fileprivate func installButtons() {
//        containerView.removeAllSubviews()
        var index = 0
        var preButton: UIButton?
        for title in self.titleArray! {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: UIControlState())
            button.setTitleColor(inactiveColor, for: UIControlState())
            button.titleLabel?.font = UIFont.applicationContentFont
            button.addTarget(self, action: #selector(AnimateSegmentControl.toSelect(_:)), for: .touchUpInside)
            button.tag = 1000 + index
            self.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top)
                if index == 0 {
                    make.leading.equalTo(self.snp.leading)
                }
                else {
                    make.leading.equalTo((preButton?.snp.trailing)!)
                }
                make.bottom.equalTo(self.snp.bottom).offset(3)
                make.width.equalTo(self.snp.width).dividedBy(self.titleArray!.count)
            }
            
            index += 1
            preButton = button
        }
        
        self.indicatorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(self.snp.width).dividedBy((self.titleArray?.count)!)
            make.height.equalTo(3)
        }
    }
    
    func reloadButtonColor() {
        for view in self.subviews {
            if view.isKind(of: UIButton.self) {
                
                let button = view as! UIButton
                let indicatorLeft = self.indicatorView.frame.minX
                let indicatorWidth = self.indicatorView.frame.width
                let viewLeft = button.frame.minX
                
                if indicatorLeft >= viewLeft && indicatorLeft < viewLeft + indicatorWidth  {
                    button.setTitleColor(activeColor, for: UIControlState())
                }
                else {
                    button.setTitleColor(inactiveColor, for: UIControlState())
                }
                
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let change = change {
            if let a: NSValue = change[NSKeyValueChangeKey.newKey] as? NSValue {
                
                var rate: CGFloat
                if a.cgPointValue.x == 0 {
                    rate = 0
                }
                else {
                    rate = a.cgPointValue.x / (self.bindScrollView?.contentSize.width)!
                }
                
                let leftMargin = rate * self.frame.width
                self.indicatorView.snp.updateConstraints({ (make) in
                    make.left.equalTo(leftMargin)
                })
            }
            
        }
        
    }
}











