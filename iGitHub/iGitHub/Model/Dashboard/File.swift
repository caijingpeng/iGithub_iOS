//
//  File.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/7.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation

/*
 {
 "name": "README.md",
 "path": "README.md",
 "sha": "598806e5572ab224883e05f5a7e8029152f5427c",
 "size": 1041,
 "url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/contents/README.md?ref=master",
 "html_url": "https://github.com/caijingpeng/UIWebView-Markdown/blob/master/README.md",
 "git_url": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/blobs/598806e5572ab224883e05f5a7e8029152f5427c",
 "download_url": "https://raw.githubusercontent.com/caijingpeng/UIWebView-Markdown/master/README.md",
 "type": "file",
 "content": "VUlXZWJWaWV3LU1hcmtkb3duCj09PT09PT09PT09PT09PT09PQoKQSByZWFs\nbHkgc2ltcGxlIENhdGVnb3J5IGZvciBVSVdlYlZpZXcgdG8gZ2l2ZSBkZXZl\nbG9wZXJzIHRoZSBvcHRpb24gdG8gbG9hZCBbTWFya2Rvd25dKGh0dHA6Ly9k\nYXJpbmdmaXJlYmFsbC5uZXQvcHJvamVjdHMvbWFya2Rvd24vKSBpbnN0ZWFk\nIG9mIEhUTUwsIGFuZCBzcGVjaWZ5IGEgc3R5bGVzaGVldC4KClRoaXMgQ2F0\nZWdvcnkgaXMgc28gc2ltcGxlLCB5b3VyIGNhdCBjb3VsZCB1c2UgaXQuIFdh\nbnQgdG8gbG9hZCBzb21lIE1hcmtkb3duIG9uIGEgVUlXZWJWaWV3IGluc3Rl\nYWQgb2YgSFRNTD8gQ2hlY2sgdGhpcyBvdXQsIGl0J3MgYSBzaW1wbGUgVmll\nd0NvbnRyb2xsZXIgd2l0aCBhIFVJV2ViVmlldyByZWZlcmVuY2UsIGB3ZWJW\naWV3YC4KCmBgYG9iamVjdGl2ZS1jCiNpbXBvcnQgIk1ZU3VwZXJTaW1wbGVW\naWV3Q29udHJvbGxlci5oIgojaW1wb3J0ICJVSVdlYlZpZXcrTWFya2Rvd24u\naCIKCkBpbXBsZW1lbnRhdGlvbiBNWVN1cGVyU2ltcGxlVmlld0NvbnRyb2xs\nZXIKCi0gKHZvaWQpdmlld0RpZExvYWQKewogICAgW3N1cGVyIHZpZXdEaWRM\nb2FkXTsKICAgIFtzZWxmLndlYlZpZXcgbG9hZE1hcmtkb3duU3RyaW5nOkAi\nIyBIb3cgdG8gV3JpdGUgTWFya2Rvd25cbiogU3RhcnQgd2l0aCBzb21lIGJ1\nbGxldCBwb2ludHNcbiogQ3J1Y2lhbGx5LCB5b3Ugd2FudCB0byAqKmVtcGhh\nc2lzKiogdGhlIF9pbXBvcnRhbnRfIHBvaW50cyJdOwp9CgpAZW5kCmBgYAoK\nU2VyaW91c2x5LCB0aGF0J3MgYWxsIHlvdSBuZWVkIHRvIGdldCBzdGFydGVk\nLgoKQ2hlY2sgb3V0IHRoZSBjb21tZW50cyBpbiBgVUlXZWJWaWV3K01hcmtk\nb3duLmhgIGlmIHlvdSB3YW50IHRvIHNlZSB0aGUgb3RoZXIgb3B0aW9ucywg\nc3VjaCBhcyBzcGVjaWZ5aW5nIENTUywgb3IgYSBTdHlsZXNoZWV0LgoKQW5k\nIGlmIHlvdSB3YW50IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgTWFya2Rvd24s\nIHNlZSBodHRwOi8vZGFyaW5nZmlyZWJhbGwubmV0L3Byb2plY3RzL21hcmtk\nb3duLy4K\n",
 "encoding": "base64",
 "_links": {
 "self": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/contents/README.md?ref=master",
 "git": "https://api.github.com/repos/caijingpeng/UIWebView-Markdown/git/blobs/598806e5572ab224883e05f5a7e8029152f5427c",
 "html": "https://github.com/caijingpeng/UIWebView-Markdown/blob/master/README.md"
 }
 }
 */

struct File: DictionaryToStruct {
    
    var name: String
    var path: String
    var sha: String
    var size: String
    var url: String
    var htmlUrl: String
    var gitUrl: String
    var downloadUrl: String
    var type: String
    var content: String
    var encoding: String
    var links: Links
    
    init(dictionary: Dictionary<String, Any>) {
        self.name = "\(unwrap(dictionary["name"]))"
        self.path = "\(unwrap(dictionary["path"]))"
        self.sha = "\(unwrap(dictionary["sha"]))"
        self.size = "\(unwrap(dictionary["size"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        self.htmlUrl = "\(unwrap(dictionary["html_url"]))"
        self.gitUrl = "\(unwrap(dictionary["git_url"]))"
        self.downloadUrl = "\(unwrap(dictionary["download_url"]))"
        self.type = "\(unwrap(dictionary["type"]))"
        self.content = "\(unwrap(dictionary["content"]))"
        self.encoding = "\(unwrap(dictionary["encoding"]))"
        self.links = Links(dictionary: dictionary["_links"] as! Dictionary)
    }
}

struct Links: DictionaryToStruct {
    var linksSelf: String
    var git: String
    var html: String
    var issue: String?
    var comments: String?
    var reviewComments: String?
    var reviewComment: String?
    var commits: String?
    var statuses: String?
    
    init(dictionary: Dictionary<String, Any>) {
        self.linksSelf = "\(unwrap(dictionary["self"]))"
        self.git = "\(unwrap(dictionary["git"]))"
        self.html = "\(unwrap(dictionary["html"]))"
        
        if let dic = dictionary["self"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.linksSelf = href
        }
        
        if let dic = dictionary["html"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.html = href
        }
        
        if let dic = dictionary["issue"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.issue = href
        }
        
        if let dic = dictionary["comments"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.comments = href
        }
        
        if let dic = dictionary["review_comments"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.reviewComments = href
        }
        
        if let dic = dictionary["review_comment"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.reviewComment = href
        }
        
        if let dic = dictionary["commits"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.commits = href
        }
        
        if let dic = dictionary["statuses"] as? Dictionary<String, String>,
            let href: String = dic["href"]! {
            self.statuses = href
        }
    }
}



















