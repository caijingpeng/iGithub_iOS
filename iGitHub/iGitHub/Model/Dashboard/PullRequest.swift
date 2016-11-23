//
//  PullRequest.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/4.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

struct PullRequest: DictionaryToStruct, Parseable {
    var url: String
    var pullRequestId: String
    var htmlUrl: String
    var diffUrl: String
    var patchUrl: String
    var issueUrl: String
    var number: Int
    var state: String
    var locked: Bool?
    var title: String
    var user: Owner?
    var body: String
    var createdAt: Date
    var updatedAt: Date
    var closedAt: Date
    var mergedAt: Date
    var mergeCommitSha: String
    var assignee: String
    var assignees: String
    var milestone: String
    var commitsUrl: String
    var reviewCommentsUrl: String
    var reviewCommentUrl: String
    var commentsUrl: String
    var statuesUrl: String
    var head: GitLabel?
    var base: GitLabel?
    var links: Links?
    var merged: Bool?
    var mergeable: String
    var mergeableState: String
    var mergedBy: Owner?
    var comments: Int?
    var reviewComments: Int?
    var commits: Int?
    var additions: Int?
    var deletions: Int?
    var changedFiles: Int?
    
    init(dictionary: Dictionary<String, Any>) {
        self.url = "\(unwrap(dictionary["url"]))"
        self.pullRequestId = "\(unwrap(dictionary["id"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.diffUrl = "\(unwrap(dictionary["diff_url"]))"
        self.patchUrl = "\(unwrap(dictionary["patch_url"]))"
        self.issueUrl = "\(unwrap(dictionary["issue_url"]))"
        self.number = Int("\(unwrap(dictionary["number"]))")!
        self.state = "\(unwrap(dictionary["state"]))"
        self.locked = dictionary["locked"] as? Bool
        self.title = "\(unwrap(dictionary["title"]))"
        if let dic = dictionary["user"] as? Dictionary<String, AnyObject> {
            self.user = Owner(dictionary: dic)
        }
        self.body = "\(unwrap(dictionary["body"]))"
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate()
        self.updatedAt = "\(unwrap(dictionary["updated_at"]))".toDate()
        self.closedAt = "\(unwrap(dictionary["closed_at"]))".toDate()
        self.mergedAt = "\(unwrap(dictionary["merged_at"]))".toDate()
        self.mergeCommitSha = "\(unwrap(dictionary["merge_commit_sha"]))"
        self.assignee = "\(unwrap(dictionary["assignee"]))"
        self.assignees = "\(unwrap(dictionary["assignees"]))"
        self.milestone = "\(unwrap(dictionary["milestone"]))"
        self.commitsUrl = "\(unwrap(dictionary["commits_url"]))"
        self.reviewCommentsUrl = "\(unwrap(dictionary["review_comments_url"]))"
        self.reviewCommentUrl = "\(unwrap(dictionary["review_comment_url"]))"
        self.commentsUrl = "\(unwrap(dictionary["comments_url"]))"
        self.statuesUrl = "\(unwrap(dictionary["statues_url"]))"
        if let dic = dictionary["head"] as? Dictionary<String, AnyObject> {
            self.head = GitLabel(dictionary: dic)
        }
        if let dic = dictionary["base"] as? Dictionary<String, AnyObject> {
            self.base = GitLabel(dictionary: dic)
        }
        if let dic = dictionary["_links"] as? Dictionary<String, AnyObject> {
            self.links = Links(dictionary: dic)
        }
        self.merged = dictionary["merged"] as? Bool
        self.mergeable = "\(unwrap(dictionary["mergeable"]))"
        self.mergeableState = "\(unwrap(dictionary["mergeable_state"]))"
        if let dic = dictionary["merged_by"] as? Dictionary<String, AnyObject> {
            self.mergedBy = Owner(dictionary: dic)
        }
        self.comments = Int("\(unwrap(dictionary["comments"]))")
        self.reviewComments = Int("\(unwrap(dictionary["review_comments"]))")
        self.commits = Int("\(unwrap(dictionary["commits"]))")
        self.additions = Int("\(unwrap(dictionary["additions"]))")
        self.deletions = Int("\(unwrap(dictionary["deletions"]))")
        self.changedFiles = Int("\(unwrap(dictionary["changed_files"]))")
        
    }
    
}

struct GitLabel: DictionaryToStruct {
    var label: String
    var ref: String
    var sha: String
    var user: Owner?
    var repo: Repository?
    
    init(dictionary: Dictionary<String, Any>) {
        self.label = "\(unwrap(dictionary["label"]))"
        self.ref = "\(unwrap(dictionary["ref"]))"
        self.sha = "\(unwrap(dictionary["sha"]))"
        if let user = dictionary["user"] as? Dictionary<String, AnyObject> {
            self.user = Owner(dictionary: user)
        }
        if let repo = dictionary["repo"] as? Dictionary<String, AnyObject> {
            self.repo = Repository(dictionary: repo)
        }
    }
}




