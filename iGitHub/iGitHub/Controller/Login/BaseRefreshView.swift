//
//  BaseRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/6.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
//import SnapKit

let FirstPage = 1

class BaseRefreshView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var currentPage: Int = FirstPage
    var pageCount: Int = 15
    
    fileprivate lazy var activity: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return a
    }()
    
    fileprivate lazy var accessoryView: UIView = {
        // 辅助 activity 找到底部位置
        let a = UIView(frame: CGRect(x: 0, y: 1000, width: 1, height: 1))
        return a
    }()
    
    fileprivate lazy var emptyView: EmptyDataView = {
        // 辅助 activity 找到底部位置
        let a = EmptyDataView.instanceView()
        return a
    }()
    
    fileprivate var isLoading: Bool = false
    var isEndPage: Bool = false {
        didSet {
            if isEndPage {
                self.activity.isHidden = true
            }
            else {
                self.activity.isHidden = false
            }
        }
    }
    
    var pagination: Bool = true {
        didSet {
            if pagination {
                isEndPage = false
                self.refreshControl.isHidden = false
            }
            else {
                isEndPage = true
                self.refreshControl.isHidden = true
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BaseRefreshView.beginRefreshing), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tableView.backgroundColor = UIColor.applicationBackgroundColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.addSubview(self.tableView)
        self.tableView.addSubview(self.activity)
        self.tableView.addSubview(self.refreshControl)
        self.tableView.addSubview(self.accessoryView)
        self.tableView.keyboardDismissMode = .onDrag

        self.addSubview(self.emptyView)
        self.emptyView.isHidden = true
    }
    
    override func updateConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        }
        
        self.activity.snp.makeConstraints { make in
            make.centerX.equalTo(self.tableView)
            make.centerY.equalTo(self.accessoryView.snp.bottom).offset(20)
        }
        
        self.emptyView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        }
        
        super.updateConstraints()
    }
    
    func beginRefreshing() {
        self.currentPage = FirstPage
        isLoading = true
        if self.refreshControl.isRefreshing == false {
            self.refreshControl.beginRefreshing()
        }
        self.handleRefresh(self.refreshControl)
    }
    
    func endRefreshing(_ successLoaded: Bool = false) {
        
        if successLoaded {
            self.currentPage += 1
            isEndPage = false
        }
        
        self.refreshControl.endRefreshing()
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.reloadData()
        self.activity.stopAnimating()
        isLoading = false
        self.emptyView.isHidden = self.tableView.numberOfRows(inSection: 0) > 0
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            
            if self.tableView.contentSize.height != 0 {
                self.accessoryView.frame = CGRect(x: 0, y: self.tableView.contentSize.height, width: 1, height: 1)
            }
            
            if self.tableView.contentSize.height > self.tableView.frame.size.height {
                let bottomOffset = (self.tableView.contentOffset.y + self.tableView.frame.height) - self.tableView.contentSize.height
                if isLoading == false && bottomOffset > -40 && !isEndPage {
                    self.activity.startAnimating()
                    isLoading = true
                    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0)
                    self.handleRefresh(self.refreshControl)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
    
}
