//
//  CodeSearchResultView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/14.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class CodeSearchResultView: BaseRefreshView {

    var datasource: Array<Repository>?
    var selectedRepository: ((_ repository: Repository) -> Void)?
    var searchKey: String?
    var searchCount: Int = 0
    
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
        
        // https://developer.github.com/v3/search/#search-repositories
        
        var param : [String: Any]? = ["page": currentPage,
                                      "per_page": pageCount,
                                      "q": searchKey ?? "",
                                      "order": "desc"]
        
        requestSearchRepositories(&param) { (response) in
            guard response.error == nil else {
                self.endRefreshing()
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as? Dictionary<String, Any> {
                
                let searchResult = SearchResult<Repository>(dictionary: result)
                let infoArray: [Repository] = searchResult.items
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
                self.endRefreshing()
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
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
