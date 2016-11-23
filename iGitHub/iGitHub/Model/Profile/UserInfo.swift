//
//  UserInfo.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/3.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices
import UIKit
/*
 
 "avatar_url" = "https://avatars.githubusercontent.com/u/6284799?v=3";
 bio = "less read more think";
 blog = "<null>";
 collaborators = 0;
 company = GongYu;
 "created_at" = "2013-12-30T06:38:21Z";
 "disk_usage" = 0;
 email = "caijingpeng0418@gmail.com";
 "events_url" = "https://api.github.com/users/caijingpeng/events{/privacy}";
 followers = 2;
 "followers_url" = "https://api.github.com/users/caijingpeng/followers";
 following = 4;
 "following_url" = "https://api.github.com/users/caijingpeng/following{/other_user}";
 "gists_url" = "https://api.github.com/users/caijingpeng/gists{/gist_id}";
 "gravatar_id" = "";
 hireable = "<null>";
 "html_url" = "https://github.com/caijingpeng";
 id = 6284799;
 location = Suzhou;
 login = caijingpeng;
 name = caijingpeng;
 "organizations_url" = "https://api.github.com/users/caijingpeng/orgs";
 "owned_private_repos" = 0;
 plan =     {
 collaborators = 0;
 name = free;
 "private_repos" = 0;
 space = 976562499;
 };
 "private_gists" = 0;
 "public_gists" = 0;
 "public_repos" = 1;
 "received_events_url" = "https://api.github.com/users/caijingpeng/received_events";
 "repos_url" = "https://api.github.com/users/caijingpeng/repos";
 "site_admin" = 0;
 "starred_url" = "https://api.github.com/users/caijingpeng/starred{/owner}{/repo}";
 "subscriptions_url" = "https://api.github.com/users/caijingpeng/subscriptions";
 "total_private_repos" = 0;
 type = User;
 "updated_at" = "2016-08-01T04:46:32Z";
 url = "https://api.github.com/users/caijingpeng";
 */

struct UserPlan {
    var name: String
    var space: String
    var privateRepos: String
    var collaborators: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.name = "\(unwrap(dictionary["name"]))"
        self.space = "\(unwrap(dictionary["space"]))"
        self.privateRepos = "\(unwrap(dictionary["private_repos"]))"
        self.collaborators = "\(unwrap(dictionary["collaborators"]))"
    }
}

struct UserInfo: Equatable, Parseable, DictionaryToStruct {
    
    var bio: String
    var blog: String
    var collaborators: String
    var company: String
    var createdAt: Date
    var diskUsage: String
    var email: String
    var followers: String
    var following: String
    var hireable: String
    var location: String
    var name: String
    var ownedPrivateRepos: String
    var privateGists: String
    var publicGists: String
    var publicRepos: String
    var totalPrivateRepos: String
    var updatedAt: Date
    var plan: UserPlan?
    
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
    var siteAdmin: String
    
    var isFollow: Bool?
    
    var avatar: UIImage?

    init(dictionary: Dictionary<String, Any>) {
        
        self.bio = "\(unwrap(dictionary["bio"]))"
        self.blog = "\(unwrap(dictionary["blog"]))"
        self.collaborators = "\(unwrap(dictionary["collaborators"]))"
        self.company = "\(unwrap(dictionary["company"]))"
        self.createdAt = "\(unwrap(dictionary["created_at"]))".toDate() as Date
        self.diskUsage = "\(unwrap(dictionary["disk_usage"]))"
        self.email = "\(unwrap(dictionary["email"]))"
        self.followers = "\(unwrap(dictionary["followers"]))"
        self.following = "\(unwrap(dictionary["following"]))"
        self.hireable = "\(unwrap(dictionary["hireable"]))"
        self.location = "\(unwrap(dictionary["location"]))"
        self.name = "\(unwrap(dictionary["name"]))"
        self.ownedPrivateRepos = "\(unwrap(dictionary["owned_private_repos"]))"
        self.privateGists = "\(unwrap(dictionary["private_gists"]))"
        self.publicGists = "\(unwrap(dictionary["public_gists"]))"
        self.publicRepos = "\(unwrap(dictionary["public_repos"]))"
        self.totalPrivateRepos = "\(unwrap(dictionary["total_private_repos"]))"
        self.updatedAt = "\(unwrap(dictionary["updated_at"]))".toDate() as Date
        
        if let dic = dictionary["plan"] {
            self.plan = UserPlan(dictionary: dic as! Dictionary<String, AnyObject>)
        }
        
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
        self.siteAdmin = "\(unwrap(dictionary["site_admin"]))"
        self.starredUrl = "\(unwrap(dictionary["starred_url"]))"
        self.subscriptionsUrl = "\(unwrap(dictionary["subscriptions_url"]))"
        self.url = "\(unwrap(dictionary["url"]))"
        
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
        
    }
 
    
    public func loadPicture() -> UIImage {
        return UIImage.init(contentsOfFile: avatarUrl) ?? UIImage()
    }
    
    public func loadSmallPicture() -> UIImage {
        let fullImage = loadPicture()
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        fullImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return smallImage!
    }
}

extension UserInfo {
    
    public static let domainIdentifier = "com.igithub.search.user"
    public var userActivityUserInfo: [AnyHashable: Any] {
        return ["loginName": login]
    }
    
    public var userActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: UserInfo.domainIdentifier)
        activity.title = login
        activity.userInfo = userActivityUserInfo
        activity.keywords = [login, bio, name]
        activity.contentAttributeSet = attributeSet
        return activity
    }
    
    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: kUTTypeText as String)
        attributeSet.title = login
        attributeSet.contentDescription = bio.absString()
        if let a = avatar {
            attributeSet.thumbnailData = UIImagePNGRepresentation(a)
        }
        attributeSet.keywords = [login, bio, name]
        return attributeSet
    }
}




func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    return lhs.userId == rhs.userId
}

func getValueByKey(_ obj:AnyObject, key: String) -> Any {
    let hMirror = Mirror(reflecting: obj)
    for case let (label?, value) in hMirror.children {
        if label == key {
            return unwrap(value)
        }
    }
    return NSNull()
}

func unwrap(_ any:Any) -> Any {
    let mi = Mirror(reflecting: any)
    if mi.displayStyle != .optional {
        return any
    }
    
    if mi.children.count == 0 { return any }
    let (_, some) = mi.children.first!
    return some
}



















