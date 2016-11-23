//
//  Issue.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

/*
 "issue": {
 "url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/843",
 "repository_url": "https://api.github.com/repos/ReactiveX/RxSwift",
 "labels_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/843/labels{/name}",
 "comments_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/843/comments",
 "events_url": "https://api.github.com/repos/ReactiveX/RxSwift/issues/843/events",
 "html_url": "https://github.com/ReactiveX/RxSwift/issues/843",
 "id": 172370111,
 "number": 843,
 "title": "Value of type 'UITableView' has no member 'Element' ",
 "user": {
 "login": "caijingpeng",
 "id": 6284799,
 "avatar_url": "https://avatars.githubusercontent.com/u/6284799?v=3",
 "gravatar_id": "",
 "url": "https://api.github.com/users/caijingpeng",
 "html_url": "https://github.com/caijingpeng",
 "followers_url": "https://api.github.com/users/caijingpeng/followers",
 "following_url": "https://api.github.com/users/caijingpeng/following{/other_user}",
 "gists_url": "https://api.github.com/users/caijingpeng/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/caijingpeng/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/caijingpeng/subscriptions",
 "organizations_url": "https://api.github.com/users/caijingpeng/orgs",
 "repos_url": "https://api.github.com/users/caijingpeng/repos",
 "events_url": "https://api.github.com/users/caijingpeng/events{/privacy}",
 "received_events_url": "https://api.github.com/users/caijingpeng/received_events",
 "type": "User",
 "site_admin": false
 },
 "labels": [],
 "state": "closed",
 "locked": false,
 "assignee": null,
 "assignees": [],
 "milestone": null,
 "comments": 0,
 "created_at": "2016-08-22T05:01:47Z",
 "updated_at": "2016-08-23T04:18:31Z",
 "closed_at": "2016-08-23T04:18:31Z",
 "body": "I use pod install RxSwift,RxCocoa(2.6.0), but I don't call rx_itemsWithDataSource function. Error of 'Value of type 'UITableView' has no member 'Element' '.My Xcode is 7.3"
 }
 */

struct Issue: Parseable, DictionaryToStruct {
    
    var url: String
    var repositoryUrl: String
    var labelsUrl: String
    var commentsUrl: String
    var eventsUrl: String
    var htmlUrl: String
    var issueId: String
    var number: String
    var title: String
    var user: Owner?
    var labels: Labels?
    var state: String
    var locked: Bool
    var assignee: String
    var assignees: String
    var milestone: String
    var comments: Int
    var createAt: Date
    var updatedAt: Date
    var closedAt: Date
    var body: String
    
    
    init(dictionary: Dictionary<String, Any>) {
        
        self.url = "\(unwrap(dictionary["url"]))"
        self.repositoryUrl = "\(unwrap(dictionary["repository_url"]))"
        self.labelsUrl = "\(unwrap(dictionary["labels_url"]))"
        self.commentsUrl = "\(unwrap(dictionary["comments_url"]))"
        self.eventsUrl = "\(unwrap(dictionary["events_url"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.issueId = "\(unwrap(dictionary["issue_id"]))"
        self.number = "\(unwrap(dictionary["number"]))"
        self.title = "\(unwrap(dictionary["title"]))"
        if let dic = dictionary["user"] as? Dictionary<String, Any> {
            self.user = Owner(dictionary: dic)
        }
        
        if let dic = dictionary["labels"] as? Dictionary<String, Any> {
            self.labels = Labels(dictionary: dic)
        }
        self.state = "\(unwrap(dictionary["state"]))"
        self.locked = dictionary["locked"] as! Bool
        self.assignee = "\(unwrap(dictionary["assignee"]))"
        self.assignees = "\(unwrap(dictionary["assignees"]))"
        self.milestone = "\(unwrap(dictionary["milestone"]))"
        self.comments = Int("\(unwrap(dictionary["comments"]))") ?? 0
        self.createAt = "\(unwrap(dictionary["created_at"]))".toDate()
        self.updatedAt = "\(unwrap(dictionary["updated_at"]))".toDate()
        self.closedAt = "\(unwrap(dictionary["closed_at"]))".toDate()
        self.body = "\(unwrap(dictionary["body"]))"
        
    }
    
}

struct Labels: DictionaryToStruct {
    
    var url: String
    var name: String
    var color: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.url = "\(unwrap(dictionary["url"]))"
        self.name = "\(unwrap(dictionary["name"]))"
        self.color = "\(unwrap(dictionary["color"]))"
    }
}
