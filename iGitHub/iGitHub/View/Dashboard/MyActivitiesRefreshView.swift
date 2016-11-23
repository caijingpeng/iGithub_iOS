//
//  MyActivitiesRefreshView.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/5.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class MyActivitiesRefreshView: BaseRefreshView {

    var datasource: Array<Activity>?
    var selectedActivity: ((_ activity: Activity) -> Void)?
    var username: String?
    
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
        self.tableView.register(ActivityCell.self)
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        var param : [String: Any]? = ["page": currentPage,
                                      "per_page": pageCount]
        
        requestMyActivity(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: [Dictionary<String, Any>] = response.value as? [Dictionary<String, Any>] {
                
                let infoArray: [Activity] = Activity.parseArray(result)
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
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ActivityCell
        cell.configurateActivity(datasource![(indexPath as NSIndexPath).row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedActivity != nil {
            selectedActivity!(datasource![(indexPath as NSIndexPath).row])
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
