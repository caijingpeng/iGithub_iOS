//
//  Repository.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

/*
 {
 "id": 64381909,
 "name": "UIWebView-Markdown",
 "full_name": "caijingpeng/UIWebView-Markdown",
 "owner": {
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
 "private": false,
 "html_url": "https://github.com/caijingpeng/UIWebView-Markdown",
 "description": "A really simple extension of UIWebView to give developers the option to load Markdown instead of HTML, and specify a stylesheet.",
 "fork": true,
 "url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown",
 "forks_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/forks",
 "keys_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/keys{/key_id}",
 "collaborators_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/collaborators{/collaborator}",
 "teams_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/teams",
 "hooks_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/hooks",
 "issue_events_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/issues/events{/number}",
 "events_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/events",
 "assignees_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/assignees{/user}",
 "branches_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/branches{/branch}",
 "tags_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/tags",
 "blobs_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/blobs{/sha}",
 "git_tags_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/tags{/sha}",
 "git_refs_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/refs{/sha}",
 "trees_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/trees{/sha}",
 "statuses_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/statuses/{sha}",
 "languages_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/languages",
 "stargazers_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/stargazers",
 "contributors_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/contributors",
 "subscribers_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/subscribers",
 "subscription_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/subscription",
 "commits_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/commits{/sha}",
 "git_commits_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/commits{/sha}",
 "comments_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/comments{/number}",
 "issue_comment_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/issues/comments{/number}",
 "contents_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/contents/{+path}",
 "compare_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/compare/{base}...{head}",
 "merges_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/merges",
 "archive_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/{archive_format}{/ref}",
 "downloads_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/downloads",
 "issues_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/issues{/number}",
 "pulls_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/pulls{/number}",
 "milestones_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/milestones{/number}",
 "notifications_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/notifications{?since,all,participating}",
 "labels_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/labels{/name}",
 "releases_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/releases{/id}",
 "deployments_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/deployments",
 "created_at": "2016-07-28T09:23:06Z",
 "updated_at": "2016-07-28T09:23:07Z",
 "pushed_at": "2013-05-02T13:39:46Z",
 "git_url": "git://github.com/caijingpeng/UIWebView-Markdown.git",
 "ssh_url": "git@github.com:caijingpeng/UIWebView-Markdown.git",
 "clone_url": "https://github.com/caijingpeng/UIWebView-Markdown.git",
 "svn_url": "https://github.com/caijingpeng/UIWebView-Markdown",
 "homepage": null,
 "size": 180,
 "stargazers_count": 0,
 "watchers_count": 0,
 "language": "Objective-C",
 "has_issues": false,
 "has_downloads": true,
 "has_wiki": false,
 "has_pages": false,
 "forks_count": 0,
 "mirror_url": null,
 "open_issues_count": 0,
 "forks": 0,
 "open_issues": 0,
 "watchers": 0,
 "default_branch": "master",
 "permissions": {
 "admin": true,
 "push": true,
 "pull": true
 }
 }
 */

struct Repository: CustomDebugStringConvertible, Parseable, DictionaryToStruct {
    
    var repositoryId: String
    var name: String
    var fullName: String
    var owner: Owner
    var repositoryPrivate: Bool
    var htmlUrl: String
    var description: String
    var fork: Bool
    var url: String
    var forksUrl: String
    var keysUrl: String
    var collaboratorsUrl: String
    var teamsUrl: String
    var hooksUrl: String
    var issueEventsUrl: String
    var eventsUrl: String
    var assigneesUrl: String
    var branchesUrl: String
    var tagsUrl: String
    var blobsUrl: String
    var gitTagsUrl: String
    var gitRefsUrl: String
    var treesUrl: String
    var statusesUrl: String
    var languagesUrl: String
    var stargazersUrl: String
    var contributorsUrl: String
    var subscribersUrl: String
    var subscriptionUrl: String
    var commitsUrl: String
    var gitCommitsUrl: String
    var commentsUrl: String
    var issueCommentUrl: String
    var contentsUrl: String
    var compareUrl: String
    var mergesUrl: String
    var archiveUrl: String
    var downloadsUrl: String
    var issuesUrl: String
    var pullsUrl: String
    var milestonesUrl: String
    var notificationsUrl: String
    var labelsUrl: String
    var releasesUrl: String
    var deploymentsUrl: String
    var createdAt: Date
    var updatedAt: Date
    var pushedAt: Date
    var gitUrl: String
    var sshUrl: String
    var cloneUrl: String
    var svnUrl: String
    var homepage: String
    var size: String
    var stargazersCount: String
    var watchersCount: String
    var language: String
    var hasIssues: Bool
    var hasDownloads: Bool
    var hasWiki: Bool
    var hasPages: Bool
    var forksCount: String
    var mirrorUrl: String
    var openIssuesCount: String
    var forks: String
    var openIssues: String
    var watchers: String
    var defaultBranch: String
    var permissions: Permission?
    
    /*
     The parent and source objects are present when the repository is a fork. parent is the repository this repository was forked from, source is the ultimate source for the network.
     */
//    var organization: Owner
    
    init(dictionary: Dictionary<String, Any>) {
        
        self.repositoryId = "\(unwrap(dictionary["id"]))"
        self.name = "\(unwrap(dictionary["name"]))"
        self.fullName = "\(unwrap(dictionary["full_name"]))"
        self.owner = Owner(dictionary: dictionary["owner"] as! Dictionary)
        self.repositoryPrivate = dictionary["private"] as! Bool
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.description = "\(unwrap(dictionary["description"]))"
        self.fork = dictionary["fork"] as! Bool
        self.url = "\(unwrap(dictionary["url"]))"
        self.forksUrl = "\(unwrap(dictionary["forks_url"]))"
        self.keysUrl = "\(unwrap(dictionary["keys_url"]))"
        self.collaboratorsUrl = "\(unwrap(dictionary["collaborators_url"]))"
        self.teamsUrl = "\(unwrap(dictionary["teams_url"]))"
        self.hooksUrl = "\(unwrap(dictionary["hooks_url"]))"
        self.issueEventsUrl = "\(unwrap(dictionary["issue_events_url"]))"
        self.eventsUrl = "\(unwrap(dictionary["events_url"]))"
        self.assigneesUrl = "\(unwrap(dictionary["assignees_url"]))"
        self.branchesUrl = "\(unwrap(dictionary["branches_url"]))"
        self.tagsUrl = "\(unwrap(dictionary["tags_url"]))"
        self.blobsUrl = "\(unwrap(dictionary["blobs_url"]))"
        self.gitTagsUrl = "\(unwrap(dictionary["git_tags_url"]))"
        self.gitRefsUrl = "\(unwrap(dictionary["git_refs_url"]))"
        self.treesUrl = "\(unwrap(dictionary["trees_url"]))"
        self.statusesUrl = "\(unwrap(dictionary["statuses_url"]))"
        self.languagesUrl = "\(unwrap(dictionary["languages_url"]))"
        self.stargazersUrl = "\(unwrap(dictionary["stargazers_url"]))"
        self.contributorsUrl = "\(unwrap(dictionary["contributors_url"]))"
        self.subscribersUrl = "\(unwrap(dictionary["subscribers_url"]))"
        self.subscriptionUrl = "\(unwrap(dictionary["subscription_url"]))"
        self.commitsUrl = "\(unwrap(dictionary["commits_url"]))"
        self.gitCommitsUrl = "\(unwrap(dictionary["git_commits_url"]))"
        self.commentsUrl = "\(unwrap(dictionary["comments_url"]))"
        self.issueCommentUrl = "\(unwrap(dictionary["issue_comment_url"]))"
        self.contentsUrl = "\(unwrap(dictionary["contents_url"]))"
        self.compareUrl = "\(unwrap(dictionary["compare_url"]))"
        self.mergesUrl = "\(unwrap(dictionary["merges_url"]))"
        self.archiveUrl = "\(unwrap(dictionary["archive_url"]))"
        self.downloadsUrl = "\(unwrap(dictionary["downloads_url"]))"
        self.issuesUrl = "\(unwrap(dictionary["issues_url"]))"
        self.pullsUrl = "\(unwrap(dictionary["pulls_url"]))"
        self.milestonesUrl = "\(unwrap(dictionary["milestones_url"]))"
        self.notificationsUrl = "\(unwrap(dictionary["notifications_url"]))"
        self.labelsUrl = "\(unwrap(dictionary["labels_url"]))"
        self.releasesUrl = "\(unwrap(dictionary["releases_url"]))"
        self.deploymentsUrl = "\(unwrap(dictionary["deployments_url"]))"
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate()
        self.updatedAt = "\(unwrap(dictionary["updated_at"]))".toDate()
        self.pushedAt = "\(unwrap(dictionary["pushed_at"]))".toDate()
        self.gitUrl = "\(unwrap(dictionary["git_url"]))"
        self.sshUrl = "\(unwrap(dictionary["ssh_url"]))"
        self.cloneUrl = "\(unwrap(dictionary["clone_url"]))"
        self.svnUrl = "\(unwrap(dictionary["svn_url"]))"
        self.homepage = "\(unwrap(dictionary["homepage"]))"
        self.size = "\(unwrap(dictionary["size"]))"
        self.stargazersCount = "\(unwrap(dictionary["stargazers_count"]))"
        self.watchersCount = "\(unwrap(dictionary["watchers_count"]))"
        self.language = "\(unwrap(dictionary["language"]))"
        self.hasIssues = dictionary["has_issues"] as! Bool
        self.hasDownloads = dictionary["has_downloads"] as! Bool
        self.hasWiki = dictionary["has_wiki"] as! Bool
        self.hasPages = dictionary["has_pages"] as! Bool
        self.forksCount = "\(unwrap(dictionary["forks_count"]))"
        self.mirrorUrl = "\(unwrap(dictionary["mirror_url"]))"
        self.openIssuesCount = "\(unwrap(dictionary["open_issues_count"]))"
        self.forks = "\(unwrap(dictionary["forks"]))"
        self.openIssues = "\(unwrap(dictionary["open_issues"]))"
        self.watchers = "\(unwrap(dictionary["watchers"]))"
        self.defaultBranch = "\(unwrap(dictionary["default_branch"]))"
        
        if let dic = dictionary["permissions"] as? Dictionary<String, AnyObject> {
            self.permissions = Permission(dictionary: dic)
        }
    }
    
}

extension Repository {
    var debugDescription: String {
        return "Repository id: \(self.repositoryId), fullname: \(self.fullName)"
    }
}

enum OwnerType {
    case user
    case organization
    case other
}

struct Owner: DictionaryToStruct, Parseable {
    var login: String
    var userId: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: OwnerType = .other
    var siteAdmin: Bool?

    init(dictionary: Dictionary<String, Any>) {
        
        self.avatarUrl = "\(unwrap(dictionary["avatar_url"]))"
        self.eventsUrl = "\(unwrap(dictionary["events_url"]))"
        self.followersUrl = "\(unwrap(dictionary["followers_url"]))"
        self.followingUrl = "\(unwrap(dictionary["following_url"]))"
        self.gistsUrl = "\(unwrap(dictionary["gists_url"]))"
        self.gravatarId = "\(unwrap(dictionary["gravatar_id"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.userId = "\(unwrap(dictionary["id"]))"
        self.login = "\(unwrap(dictionary["login"]))"
        self.organizationsUrl = "\(unwrap(dictionary["organizations_url"]))"
        self.receivedEventsUrl = "\(unwrap(dictionary["received_events_url"]))"
        self.reposUrl = "\(unwrap(dictionary["repos_url"]))"
        
        if let site = dictionary["site_admin"] as? Bool {
            self.siteAdmin = site
        }
        
        self.starredUrl = "\(unwrap(dictionary["starred_url"]))"
        self.subscriptionsUrl = "\(unwrap(dictionary["subscriptions_url"]))"
        
        if let t = dictionary["type"] as? String {
            
            switch t {
            case "User":
                self.type = .user
            case "Organization":
                self.type = .organization
            default:
                self.type = .other
            }
            
        }
        
        self.url = "\(unwrap(dictionary["url"]))"
    }
}

struct Permission: DictionaryToStruct {
    var admin: Bool
    var push: Bool
    var pull: Bool
    
    init(dictionary: Dictionary<String, Any>) {

        self.admin = dictionary["admin"] as! Bool
        self.push = dictionary["push"] as! Bool
        self.pull = dictionary["pull"] as! Bool
    }
}

// search api  https://www.raywenderlich.com/116608/ios-9-app-search-tutorial-introduction-to-app-search
extension Repository {
    
    public static let domainIdentifier = "com.igithub.search.repository"
    public var userActivityUserInfo: [AnyHashable: Any] {
        return ["fullName": fullName, "url": url]
    }
    
    public var userActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: Repository.domainIdentifier)
        activity.title = fullName
        activity.userInfo = userActivityUserInfo
        activity.keywords = [fullName, name, owner.login]
        activity.contentAttributeSet = attributeSet
        return activity
    }
    
    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: kUTTypeText as String)
        attributeSet.title = fullName
        attributeSet.contentDescription = "\(description)\n\(owner.login)"
        attributeSet.keywords = [fullName, name, owner.login]
        return attributeSet
    }
}




















