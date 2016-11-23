//
//  MyRepositoryRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/6.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class MyRepositoryRefreshView: BaseRefreshView {
    
    var datasource: Array<Repository>?
    var selectedRepository: ((_ repository: Repository) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(MyRepositoryCell.self)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        var param : [String: Any]? = ["page": currentPage, "per_page": pageCount]
        
        requestOwnRepository(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                
                let infoArray: [Repository] = Repository.parseArray(result)
                if self.currentPage == FirstPage {
                    self.datasource = infoArray
                }
                else {
                    self.datasource?.append(contentsOf: infoArray)
                }
                self.endRefreshing(true)
                self.isEndPage = infoArray.count < self.pageCount
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = datasource?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MyRepositoryCell
        cell.configurateRepository(datasource![(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedRepository != nil {
            selectedRepository!(datasource![(indexPath as NSIndexPath).row])
        }
    }

}
