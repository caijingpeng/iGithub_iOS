//
//  Activities.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

/*
 {
 "id": "4481851957",
 "type": "WatchEvent",
 "actor": {
 "id": 35128,
 "login": "sorrycc",
 "display_login": "sorrycc",
 "gravatar_id": "",
 "url": "https://api.github.com/users/sorrycc",
 "avatar_url": "https://avatars.githubusercontent.com/u/35128?"
 },
 "repo": {
 "id": 58329392,
 "name": "remy/retrobot",
 "url": "https://api.github.com/repos/remy/retrobot"
 },
 "payload": {
 "action": "started"
 },
 "public": true,
 "created_at": "2016-08-29T01:34:00Z"
 }
 */

struct Activity: Parseable, DictionaryToStruct {
    var activityId: String
    var type: String    // ForkEvent IssuesEvent WatchEvent PushEvent PullRequestEvent IssueCommentEvent GollumEvent DeleteEvent CreateEvent https://developer.github.com/v3/activity/events/types/
    var actor: Actor?
    var repo: Repo?
    var payload: Payload?
    var isPublic: Bool?
    var createdAt: Date
    
    init(dictionary: Dictionary<String, Any>) {
        self.activityId = "\(unwrap(dictionary["id"]))"
        self.type = "\(unwrap(dictionary["type"]))"
        if let dic = dictionary["actor"] {
            self.actor = Actor(dictionary: dic as! Dictionary<String, AnyObject>)
        }
        
        if let dic = dictionary["repo"] {
            self.repo = Repo(dictionary: dic as! Dictionary<String, AnyObject>)
        }
        
        if let pay = dictionary["payload"] {
            self.payload = Payload(dictionary: pay as! Dictionary<String, AnyObject>)
        }
        
        if let isP: Bool = dictionary["public"] as? Bool {
            self.isPublic = isP
        }
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate()
    }
}

struct Actor: DictionaryToStruct {
    var actorId: String
    var login: String
    var displayLogin: String
    var gravatarId: String
    var url: String
    var avatarUrl: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.actorId = "\(unwrap(dictionary["id"]))"
        self.login = "\(unwrap(dictionary["login"]))"
        self.displayLogin = "\(unwrap(dictionary["display_login"]))"
        self.gravatarId = "\(unwrap(dictionary["gravatar_id"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        self.avatarUrl = "\(unwrap(dictionary["avatar_url"]))"
    }
}

struct Repo: DictionaryToStruct {
    var repoId: String
    var name: String
    var url: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.repoId = "\(unwrap(dictionary["id"]))"
        self.name = "\(unwrap(dictionary["name"]))"
        self.url = "\(unwrap(dictionary["url"]))"
    }
}

struct Payload : DictionaryToStruct {
    var action: String?   // started (watchEvent)  opened,closed,created (IssueEvent)  nil (forkEvent)
    var forkee: Repository?
    var issue: Issue?
    
    // push event
    var pushId: String?
    var size: Int?
    var distinctSize: Int?
    var ref: String?
    var head: String?
    var befor: String?
    var commits: [Commit]?
    
    // pull request : action (closed)
    var number: Int?
    var pullrequest: PullRequest?
    
    // comment 
    var comment: Comment?
    
    // Gollum
    var pages: [Pages]?
    
    // delete event
    var refType: String?  // branch
    var pusherType: String?  // user
    
    // member event
    
    var member: Owner?
    
    init(dictionary: Dictionary<String, Any>) {
        
        if let a = dictionary["action"] as? String{
            self.action = a
        }
        
        if let f = dictionary["forkee"] as? Dictionary<String, AnyObject>{
            self.forkee = Repository(dictionary: f)
        }
        
        if let i = dictionary["issue"] as? Dictionary<String, AnyObject>{
            self.issue = Issue(dictionary: i)
        }
        
        if let dic = dictionary["pull_request"] as? Dictionary<String, AnyObject>{
            self.pullrequest = PullRequest(dictionary: dic)
        }
        
        if let dic = dictionary["comment"] as? Dictionary<String, AnyObject>{
            self.comment = Comment(dictionary: dic)
        }
        
        if let dic = dictionary["member"] as? Dictionary<String, AnyObject>{
            self.member = Owner(dictionary: dic)
        }
        
        if let array = dictionary["pages"] as? [Dictionary<String, AnyObject>]{
            self.pages = Pages.parseArray(array)
        }
        
        self.pushId = "\(unwrap(dictionary["push_id"]))"
        self.size = Int("\(unwrap(dictionary["size"]))")
        self.distinctSize = Int("\(unwrap(dictionary["distinct_size"]))")
        self.ref = "\(unwrap(dictionary["ref"]))"
        self.head = "\(unwrap(dictionary["head"]))"
        self.befor = "\(unwrap(dictionary["before"]))"
        
        if let array = dictionary["commits"] as? [Dictionary<String, AnyObject>]{
            self.commits = Commit.parseArray(array)
        }
        self.refType = "\(unwrap(dictionary["ref_type"]))"
        self.pusherType = "\(unwrap(dictionary["pusher_type"]))"
    }
    
}
/*
 "page_name": "Installation-Guide",
 "title": "Installation Guide",
 "summary": null,
 "action": "created",
 "sha": "7f6cc1fdc2e92706174272c5bd3a12049ad6401c",
 "html_url": "/onevcat/Kingfisher/wiki/Installation-Guide"
 */
struct Pages: DictionaryToStruct, Parseable {
    var pageName: String
    var title: String
    var summary: String
    var action: String
    var sha: String
    var htmlUrl: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.pageName = "\(unwrap(dictionary["page_name"]))"
        self.title = "\(unwrap(dictionary["title"]))"
        self.summary = "\(unwrap(dictionary["summary"]))"
        self.action = "\(unwrap(dictionary["action"]))"
        self.sha = "\(unwrap(dictionary["sha"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
    }
}

/*
 "url": "https://api.github.com/repos/onevcat/Kingfisher/issues/comments/243303246",
 "html_url": "https://github.com/onevcat/Kingfisher/issues/418#issuecomment-243303246",
 "issue_url": "https://api.github.com/repos/onevcat/Kingfisher/issues/418",
 "id": 243303246,
 "user": {
 "login": "onevcat",
 "id": 1019875,
 "avatar_url": "https://avatars.githubusercontent.com/u/1019875?v=3",
 "gravatar_id": "",
 "url": "https://api.github.com/users/onevcat",
 "html_url": "https://github.com/onevcat",
 "followers_url": "https://api.github.com/users/onevcat/followers",
 "following_url": "https://api.github.com/users/onevcat/following{/other_user}",
 "gists_url": "https://api.github.com/users/onevcat/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/onevcat/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/onevcat/subscriptions",
 "organizations_url": "https://api.github.com/users/onevcat/orgs",
 "repos_url": "https://api.github.com/users/onevcat/repos",
 "events_url": "https://api.github.com/users/onevcat/events{/privacy}",
 "received_events_url": "https://api.github.com/users/onevcat/received_events",
 "type": "User",
 "site_admin": false
 },
 "created_at": "2016-08-30T01:02:31Z",
 "updated_at": "2016-08-30T01:02:31Z",
 "body": "It's a planned feature and being implemented now. But it will only appear in next major version of Kingfisher (for Swift 3).\r\n\r\nSee #348 and https://github.com/onevcat/Kingfisher/tree/feature/image-processor"

 */

struct Comment: DictionaryToStruct {
    var url: String
    var htmlUrl: String
    var issueUrl: String
    var commentId: String
    var user: Owner?
    var createdAt: Date
    var updatedAt: Date
    var body: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.url = "\(unwrap(dictionary["url"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.issueUrl = "\(unwrap(dictionary["issue_url"]))"
        self.commentId = "\(unwrap(dictionary["id"]))"
        if let dic = dictionary["user"] as? Dictionary<String, AnyObject> {
            self.user = Owner(dictionary: dic)
        }
        
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate()
        self.updatedAt = "\(unwrap(dictionary["updated_at"]))".toDate()
        self.body = "\(unwrap(dictionary["body"]))"
    }
}



