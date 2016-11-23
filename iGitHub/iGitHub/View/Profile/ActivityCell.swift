//
//  ActivityCell.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit
import YYKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ActivityCell: BaseTableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var infoLabel: YYLabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commitInfoLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var subHeadImageView: UIImageView!
    @IBOutlet weak var subInfoLabel: UILabel!
    @IBOutlet weak var sub2HeadImageView: UIImageView!
    @IBOutlet weak var sub2InfoLabel: UILabel!
    @IBOutlet weak var subStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.timeLabel.textColor = UIColor.applicationGreyColor
        self.timeLabel.font = UIFont.applicationContentFont
        
//        self.infoLabel.textColor = UIColor.applicationDarkGreyColor
//        self.infoLabel.font = UIFont.applicationBoldTitleFont
        self.infoLabel.numberOfLines = 0
        self.infoLabel.preferredMaxLayoutWidth = self.infoLabel.width

        self.commitInfoLabel.textColor = UIColor.applicationGreyColor
        self.commitInfoLabel.font = UIFont.applicationTitleFont
        self.commitInfoLabel.backgroundColor = UIColor.applicationLightCyanColor
        
        self.subInfoLabel.textColor = UIColor.applicationDarkGreyColor
        self.subInfoLabel.font = UIFont.applicationContentFont
        
        self.sub2InfoLabel.textColor = UIColor.applicationDarkGreyColor
        self.sub2InfoLabel.font = UIFont.applicationContentFont
        
        self.commentButton.setTitleColor(UIColor.applicationBlueColor, for: UIControlState())
        self.commentButton.titleLabel?.font = UIFont.applicationSmallFont
        
        self.selectionStyle = .none
    }
    
    private func pushProfileViewController(login: String) {
        
        let userVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
        userVC.loginName = login
        userVC.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(userVC, animated: true)
    }
    
    private func pushRepoViewController(url: String) {
        
        let detail = RepositoryDetailViewController(nibName: "RepositoryDetailViewController", bundle: nil)
        detail.hidesBottomBarWhenPushed = true
        detail.url = url
        self.viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    func configurateActivity(_ activity: Activity) -> Void {
        
        if activity.type == "ForkEvent" {
            self.iconImageView.image = UIImage(named: "Branches")
            
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
               let repoName = activity.repo?.name,
               let forkName = activity.payload?.forkee?.fullName {
                
                let string = "\(actorName) forked \(repoName) to \(forkName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                let forkNameRange = string.range(of: forkName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo) \(self.viewController)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo) \(self.viewController)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(forkNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["fork": activity.payload?.forkee?.repositoryId], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo) \(self.viewController)")
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            self.headImageView.isHidden = true
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = true
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = true
        }
        else if activity.type == "IssuesEvent" {
            if activity.payload?.action == "opened" {
                self.iconImageView.image = UIImage(named: "Issue")
                self.timeLabel.text = activity.payload?.issue?.createAt.prettyDateString()
            }
            else if activity.payload?.action == "closed"{
                self.iconImageView.image = UIImage(named: "Issue")
                self.timeLabel.text = activity.payload?.issue?.closedAt.prettyDateString()
            }
            else {
                self.iconImageView.backgroundColor = UIColor.red
                self.timeLabel.text = activity.payload?.issue?.updatedAt.prettyDateString()
            }
            
            if let actorName = activity.actor?.displayLogin,
                let action = activity.payload?.action,
                let repoName = activity.repo?.name {
                
                let string = "\(actorName) \(action) issue \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                        if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                        if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            if let headUrl = activity.actor?.avatarUrl {
                self.headImageView.setImageWith(URL(string: headUrl)!, placeholder: UIImage(named: "image_placeholder"))
            }
            self.subInfoLabel.text = "\(unwrap(activity.payload?.issue!.title))"
            
            self.headImageView.isHidden = false
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = false
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = false
        }
        else if activity.type == "WatchEvent" {
            self.iconImageView.image = UIImage(named: "Star")
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name,
                let action = activity.payload?.action {
                
                let string = "\(actorName) \(action) \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                        if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                        if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            self.headImageView.isHidden = true
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = true
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = true
        }
        else if activity.type == "PushEvent" {
            self.iconImageView.image = UIImage(named: "Commit")
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if  let pushTo = activity.payload?.ref?.components(separatedBy: "/").last,
                let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name {
                
                let string = "\(actorName) pushed to \(pushTo) at \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                let pushRange = string.range(of: pushTo)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(pushRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["push": ""], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            if let headUrl = activity.actor?.avatarUrl {
                self.headImageView.setImageWith(URL(string: headUrl)!, placeholder: UIImage(named: "image_placeholder"))
            }
            
            if let commits = activity.payload?.commits,
                let firstCommits: Commit = commits[0],
                let index: String.Index = firstCommits.sha.characters.index(firstCommits.sha.startIndex, offsetBy: 6),
                let sha: String = firstCommits.sha.substring(to: index),
                let desc = firstCommits.message {
                
                self.subInfoLabel.text = "\(sha) \(desc)"
                self.subHeadImageView.isHidden = false
                self.subInfoLabel.isHidden = false
            }
            else {
                self.subHeadImageView.isHidden = true
                self.subInfoLabel.isHidden = true
            }
            
            if let commits = activity.payload?.commits,
                let secondCommits: Commit = commits[safe: 1] ?? nil,
                let index: String.Index = secondCommits.sha.characters.index(secondCommits.sha.startIndex, offsetBy: 6),
                let sha: String = secondCommits.sha.substring(to: index),
                let desc = secondCommits.message {
                
                self.sub2InfoLabel.text = "\(sha) \(desc)"
                self.sub2HeadImageView.isHidden = false
                self.sub2InfoLabel.isHidden = false
            }
            else {
                self.sub2HeadImageView.isHidden = true
                self.sub2InfoLabel.isHidden = true
            }
            
            if activity.payload?.commits?.count > 2 {
                self.commentButton.isHidden = false
                if let more: Int = (activity.payload?.commits?.count)! - 2 {
                    self.commentButton.setTitle("\(more) more commits »", for: UIControlState())
                }
            }
            else if activity.payload?.commits?.count == 2 {
                self.commentButton.isHidden = false
                self.commentButton.setTitle("View comparison for these 2 commits »", for: UIControlState())
            }
            else {
                self.commentButton.isHidden = true
            }
            
            self.headImageView.isHidden = false
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = false
        }
        else if activity.type == "PullRequestEvent" {
            self.iconImageView.image = UIImage(named: "PullRequest")
            
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            var action: String
            if activity.payload?.action == "opened" {
                action = "opened"
            }
            else if activity.payload?.action == "closed" {
                action = "merged"
            }
            else {
                action = "***"
            }
            
            if let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name,
                let pullnumber = activity.payload?.pullrequest?.number {
                
                let string = "\(actorName) \(action) pull request \(repoName))#\(pullnumber)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            if let headUrl = activity.actor?.avatarUrl {
                self.headImageView.setImageWith(URL(string: headUrl)!, placeholder: UIImage(named: "image_placeholder"))
            }
            
            if let title = activity.payload?.pullrequest?.title {
                self.subInfoLabel.text = title
            }
            
            if let commits = activity.payload?.pullrequest?.commits,
               let addition = activity.payload?.pullrequest?.additions,
               let deletion = activity.payload?.pullrequest?.deletions {
                
                self.commitInfoLabel.text = "\(commits) commits with \(addition) additions and \(deletion) deletions"
            }
            
            self.headImageView.isHidden = false
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = false
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = false
            self.subStackView.isHidden = false
        }
        else if activity.type == "IssueCommentEvent" {
            self.iconImageView.image = UIImage(named: "Comment")
            
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name,
                let number = activity.payload?.issue?.number {
                
                let string = "\(actorName) commented on issue \(repoName)#\(number)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            if let headUrl = activity.actor?.avatarUrl {
                self.headImageView.setImageWith(URL(string: headUrl)!, placeholder: UIImage(named: "image_placeholder"))
            }
            
            if let comment = activity.payload?.comment?.body {
                self.subInfoLabel.text = comment
            }
            
            self.headImageView.isHidden = false
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = false
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = false
        }
        else if activity.type == "DeleteEvent" {
            self.iconImageView.image = UIImage(named: "Branch")
            
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
                let refType = activity.payload?.refType,
                let repoName = activity.repo?.name,
                let ref = activity.payload?.ref {
                
                let string = "\(actorName) deleted \(refType) \(ref) at \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            self.headImageView.isHidden = true
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = true
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = true
        }
        else if activity.type == "GollumEvent" {
            self.iconImageView.image = UIImage(named: "Wiki")
            
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if  let pages = activity.payload?.pages,
                let pageOne: Pages = pages[0],
                let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name {
                
                let string = "\(actorName) \(pageOne.action) the \(repoName) wiki" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
                
                self.subHeadImageView.isHidden = false
                self.subInfoLabel.isHidden = false
                self.subInfoLabel.text = "\(unwrap(pageOne.action)) \(unwrap(pageOne.title))"
            }
            
            if  let pages = activity.payload?.pages,
                let pageTwo: Pages = pages[safe: 1],
                let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name {
                
                let string = "\(actorName) \(pageTwo.action) the \(repoName) wiki" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
                
                self.sub2HeadImageView.isHidden = false
                self.sub2InfoLabel.isHidden = false
                self.sub2InfoLabel.text = "\(unwrap(pageTwo.action)) \(unwrap(pageTwo.title))"
            }
            else {
                self.sub2HeadImageView.isHidden = true
                self.sub2InfoLabel.isHidden = true
            }
            
            
            if let headUrl = activity.actor?.avatarUrl {
                self.headImageView.setImageWith(URL(string: headUrl)!, placeholder: UIImage(named: "image_placeholder"))
            }
            
            self.headImageView.isHidden = false
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = false
        }
        else if activity.type == "CreateEvent" {
            self.iconImageView.image = UIImage(named: "Repository")
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name {
                
                let string = "\(actorName) \(unwrap(activity.payload?.action)) repository \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            self.headImageView.isHidden = true
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = true
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = true
        }
        else if activity.type == "MemberEvent" {
            
            self.iconImageView.image = UIImage(named: "Tab_Profile")
            self.timeLabel.text = activity.createdAt.prettyDateString()
            
            if let actorName = activity.actor?.displayLogin,
                let repoName = activity.repo?.name,
                let memberName = activity.payload?.member?.login {
                
                let string = "\(actorName) \(unwrap(activity.payload?.action)) \(memberName) to \(repoName)" as NSString
                
                let attr = NSMutableAttributedString.init(string: string as String)
                attr.font = UIFont.applicationTitleFont
                attr.color = UIColor.applicationDarkGreyColor
                
                let actorNameRange = string.range(of: actorName)
                let repoNameRange = string.range(of: repoName)
                let memberNameRange = string.range(of: memberName)
                
                
                attr.setTextHighlight(actorNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["actor": activity.actor?.login], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let login: String = highlight.userInfo?["actor"] as! String
                            self.pushProfileViewController(login: login)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(repoNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["repo": activity.repo?.url], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                            let repo: String = highlight.userInfo?["repo"] as! String
                            self.pushRepoViewController(url: repo)
                        }
                    
                    }, longPressAction: nil)
                
                attr.setTextHighlight(memberNameRange, color: UIColor.applicationDarkBlueColor, backgroundColor: UIColor.applicationGreyColor, userInfo: ["member": ""], tapAction: { (containerView, text, range, rect) in
                    
                    if let attributes = text.attributedSubstring(from: range).attributes,
                            let highlight: YYTextHighlight = attributes["YYTextHighlight"] as? YYTextHighlight {
                            print("\(highlight.userInfo)")
                        }
                    
                    }, longPressAction: nil)
                
                self.infoLabel.attributedText = attr;
            }
            
            self.headImageView.isHidden = true
            self.subHeadImageView.isHidden = true
            self.subInfoLabel.isHidden = true
            self.sub2HeadImageView.isHidden = true
            self.sub2InfoLabel.isHidden = true
            self.commentButton.isHidden = true
            self.commitInfoLabel.isHidden = true
            self.subStackView.isHidden = true
        }
        else if activity.type == "CommitCommentEvent" {
            
        }
        else if activity.type == "DeploymentEvent" {
            
        }
        else if activity.type == "DeploymentStatusEvent" {
            
        }
        else if activity.type == "DownloadEvent" {
            
        }
        else if activity.type == "FollowEvent" {
            
        }
        else if activity.type == "ForkApplyEvent" {
            
        }
        else if activity.type == "GistEvent" {
            
        }
        else if activity.type == "MembershipEvent" {
            
        }
        else if activity.type == "PageBuildEvent" {
            
        }
        else if activity.type == "PublicEvent" {
            
        }
        else if activity.type == "PullRequestReviewCommentEvent" {
            
        }
        else if activity.type == "ReleaseEvent" {
            
        }
        else if activity.type == "RepositoryEvent" {
            
        }
        else if activity.type == "StatusEvent" {
            
        }
        else if activity.type == "TeamAddEvent" {
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
