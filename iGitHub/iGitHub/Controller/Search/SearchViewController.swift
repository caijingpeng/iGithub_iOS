//
//  SearchViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navgationView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var segmentCtrl: AnimateSegmentControl!
    
    @IBOutlet weak var searchRepositoryView: RepositorySearchResultView!
    @IBOutlet weak var searchIssueView: IssuesSearchResultView!
    @IBOutlet weak var searchUserView: UsersSearchResultView!
    
    @IBOutlet weak var searchHistoryBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchHistoryView: UITableView!
    var historyDatasource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navgationView.backgroundColor = UIColor.applicationDarkBlueColor
        self.searchBar.barTintColor = UIColor.applicationDarkBlueColor
        self.searchBar.layer.borderWidth = 0
        
        self.segmentCtrl.bindScrollView = self.mainScrollView
        self.segmentCtrl.titleArray = ["Repositories", "Issues", "Users/Orgs"]
        self.segmentCtrl.drawBottomLine()
        self.topView.drawBottomLine()
        
        self.searchHistoryView.register(NormalCell.self)
        self.searchHistoryView.rowHeight = 45
        self.searchHistoryView.estimatedRowHeight = 45
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: applicationWidth, height: 40))
        footer.drawTopLine()
        self.searchHistoryView.tableFooterView = footer
        
        if let history: [String] = UserDefaults.standard.object(forKey: "SearchHistory") as? [String] {
            self.historyDatasource = history
        }
        self.searchHistoryView.isHidden = true
        
        self.searchRepositoryView.selectedRepository = { repository in
            
            let detail = RepositoryDetailViewController(nibName: "RepositoryDetailViewController", bundle: nil)
            detail.repository = repository
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
            
        }
        
        self.searchUserView.selectedUser = { user in
            if user.type == .organization {
                let orgVC = OrganizationInfoViewController(nibName: "OrganizationInfoViewController", bundle: nil)
                orgVC.hidesBottomBarWhenPushed = true
                orgVC.username = user.login
                self.navigationController?.pushViewController(orgVC, animated: true)
            }
            else if user.type == .user {
                let userVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
                userVC.loginName = user.login
                self.navigationController?.pushViewController(userVC, animated: true)
            }
        }
        
    }
    
    override func awakeFromNib() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        self.searchBar.setShowsCancelButton(true, animated: true)
        self.searchBar.setCancelButtonTextColor(UIColor.white)
        
        if self.historyDatasource.count != 0 {
            self.searchHistoryView.isHidden = false
        }
        else {
            self.searchHistoryView.isHidden = true
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchHistoryView.isHidden = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchHistoryView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.toSearch()
    }
    
    func toSearch() {
        self.searchRepositoryView.searchKey = self.searchBar.text
        self.searchIssueView.searchKey = self.searchBar.text
        self.searchUserView.searchKey = self.searchBar.text
        
        self.searchRepositoryView.beginRefreshing()
        self.searchIssueView.beginRefreshing()
        self.searchUserView.beginRefreshing()
        
        if let i = self.historyDatasource.index(of: self.searchBar.text!) {
            self.historyDatasource.remove(at: i)
        }
        self.historyDatasource.insert(self.searchBar.text!, at: 0)
        self.searchHistoryView.reloadData()
        UserDefaults.standard.set(self.historyDatasource, forKey: "SearchHistory")
        
        searchBar.resignFirstResponder()
    }
}

extension UISearchBar {
    
    func cancelButton() -> UIButton? {
        for view in (self.subviews.first?.subviews)! {
            if view.isKind(of: NSClassFromString("UINavigationButton")!) {
                let button: UIButton = view as! UIButton
                return button
            }
        }
        return nil
    }
    
    func setCancelButtonTextColor(_ color: UIColor) {
        if let button = self.cancelButton() {
            button.titleLabel?.font = UIFont.applicationTitleFont
            button.setTitleColor(UIColor.white, for: UIControlState())
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyDatasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.historyDatasource.count != 0 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: applicationWidth, height: 50))
        header.backgroundColor = UIColor.applicationLightGreyColor
        header.drawBottomLine()
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: applicationWidth, height: 50))
        label.textColor = UIColor.applicationDarkGreyColor
        label.text = "Search History"
        label.font = UIFont.applicationTitleFont
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NormalCell
        cell.titleLabelLeading.constant = 8
        cell.accessoryImageView.isHidden = true
        cell.iconImageView.isHidden = true
        cell.titleLabel.text = self.historyDatasource[indexPath.row]
        cell.titleLabel.textColor = UIColor.applicationDarkBlueColor
        cell.titleLabel.font = UIFont.applicationTitleFont
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchBar.text = self.historyDatasource[indexPath.row]
        self.toSearch()
    }
    
}






















