//
//  Organization.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/1.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

struct Organization: Parseable, DictionaryToStruct {
    var login: String
    var id: String
    var url: String
    var reposUrl: String
    var eventsUrl: String
    var hooksUrl: String
    var issuesUrl: String
    var membersUrl: String
    var publicMembersUrl: String
    var avatarUrl: String
    var description: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.login = "\(unwrap(dictionary["login"]))"
        self.id = "\(unwrap(dictionary["id"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        self.reposUrl = "\(unwrap(dictionary["repos_url"]))"
        self.eventsUrl = "\(unwrap(dictionary["events_url"]))"
        self.hooksUrl = "\(unwrap(dictionary["hooks_url"]))"
        self.issuesUrl = "\(unwrap(dictionary["issues_url"]))"
        self.membersUrl = "\(unwrap(dictionary["members_url"]))"
        self.publicMembersUrl = "\(unwrap(dictionary["public_members_url"]))"
        self.avatarUrl = "\(unwrap(dictionary["avatar_url"]))"
        self.description = "\(unwrap(dictionary["description"]))"
    }
}
/*
{
    "login": "github",
    "id": 1,
    "url": "https://api.github.com/orgs/github",
    "repos_url": "https://api.github.com/orgs/github/repos",
    "events_url": "https://api.github.com/orgs/github/events",
    "hooks_url": "https://api.github.com/orgs/github/hooks",
    "issues_url": "https://api.github.com/orgs/github/issues",
    "members_url": "https://api.github.com/orgs/github/members{/member}",
    "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
    "description": "A great organization",
 
    "name": "github",
    "company": "GitHub",
    "blog": "https://github.com/blog",
    "location": "San Francisco",
    "email": "octocat@github.com",
    "public_repos": 2,
    "public_gists": 1,
    "followers": 20,
    "following": 0,
    "html_url": "https://github.com/octocat",
    "created_at": "2008-01-14T04:33:35Z",
    "type": "Organization"
}*/

struct OrganizationDetail {
    var login: String
    var id: String
    var url: String
    var reposUrl: String
    var eventsUrl: String
    var hooksUrl: String
    var issuesUrl: String
    var membersUrl: String
    var publicMembersUrl: String
    var avatarUrl: String
    var description: String
    
    var name: String
    var company: String
    var blog: String
    var location: String
    var email: String
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var htmlUrl: Int?
    var createdAt: Date
    var type: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.login = "\(unwrap(dictionary["login"]))"
        self.id = "\(unwrap(dictionary["id"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        self.reposUrl = "\(unwrap(dictionary["repos_url"]))"
        self.eventsUrl = "\(unwrap(dictionary["events_url"]))"
        self.hooksUrl = "\(unwrap(dictionary["hooks_url"]))"
        self.issuesUrl = "\(unwrap(dictionary["issues_url"]))"
        self.membersUrl = "\(unwrap(dictionary["members_url"]))"
        self.publicMembersUrl = "\(unwrap(dictionary["public_members_url"]))"
        self.avatarUrl = "\(unwrap(dictionary["avatar_url"]))"
        self.description = "\(unwrap(dictionary["description"]))"
        
        self.name = "\(unwrap(dictionary["name"]))"
        self.company = "\(unwrap(dictionary["company"]))"
        self.blog = "\(unwrap(dictionary["blog"]))"
        self.location = "\(unwrap(dictionary["location"]))"
        self.email = "\(unwrap(dictionary["email"]))"
        self.publicRepos = Int("\(unwrap(dictionary["public_repos"]))")
        self.publicGists = Int("\(unwrap(dictionary["public_gists"]))")
        self.followers = Int("\(unwrap(dictionary["followers"]))")
        self.following = Int("\(unwrap(dictionary["following"]))")
        self.htmlUrl = Int("\(unwrap(dictionary["html_url"]))")
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate()
        self.type = "\(unwrap(dictionary["type"]))"
    }
}



