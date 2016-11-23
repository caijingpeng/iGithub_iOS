//
//  RequestManager.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/2.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import Foundation
import Alamofire

let networkQueue = DispatchQueue.global(qos: .default)

enum RequestError {
    case Auth
    case FollowingSuccess
    case Error          // 404
    case Unprocessable  // 422
    
    public var description: String {
        
        switch self {
        case .Auth:
            return "账号密码错误"
        case .Error:
            return "操作失败"
        case .Unprocessable:
            return "不可执行"
        default:
            break
        }
        
        return ""
    }
}

enum Result<A> {
    case Failure(RequestError)
    case Success(A)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: A? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: RequestError? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
}

func request(method: HTTPMethod = .get,
             url: URL,
             parameters: [String: Any]?,
             header: HTTPHeaders? = nil,
             completionHandler: @escaping (Result<Any>) -> Void) -> Void
{
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    log.info("Request: \(url) parameters: \(parameters)")
    
    Alamofire.request(url, method: method, parameters: parameters, headers: header)
        .responseJSON(queue: networkQueue) { (response) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if let statusCode = response.response?.statusCode {
                    
                    switch statusCode {
                    case 200:
                        if let JSON = response.result.value {
                            log.info("response: \(JSON)")
                            completionHandler(.Success(JSON))
                        }
                        break
                    case 204:
                        log.info("response: status code 204 is true")
                        completionHandler(.Success(true))
                        break
                    case 404:
                        log.error("\(response.request?.url)")
                        completionHandler(.Failure(.Error))
                        break
                    case 401:
                        log.error("\(response.request?.url)")
                        completionHandler(.Failure(.Auth))
                        break
                    case 400:
                        log.error("\(response.request?.url)")
                        completionHandler(.Failure(.Error))
                        break
                    case 422:
                        log.error("\(response.request?.url)")
                        completionHandler(.Failure(.Unprocessable))
                        break
                    case 403:
                        log.error("\(response.request?.url)")
                        completionHandler(.Failure(.Error))
                        break
                    default:
                        break
                    }
                }
                
                if let error = response.result.error {
                    log.error("Error: \(error.localizedDescription)")
                }
            }
    }
    
}

func requestloginUser(_ parameters: inout [String: Any]?,
                     completionHandler: @escaping (Result<Any>) -> Void) -> Void
{
    
    guard parameters!["username"] != nil else { return }
    guard parameters!["password"] != nil else { return }
    
    let username = parameters!["username"]
    let password = parameters!["password"]
    let user_pass = "\(unwrap(username)):\(unwrap(password))"
    let utf8str = user_pass.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let header = ["Authorization": "Basic \(base64Encoded!)"]
    
    do {
        let url = try "https://api.github.com/user".asURL()
        request(url: url, parameters: parameters, header: header, completionHandler: completionHandler)
    }
    catch {
        
    }
    
}

func requestOwnRepository(_ parameters: inout [String: Any]?,
                                completionHandler: @escaping (Result<Any>) -> Void) -> Void
{
    /*
     1.visibility     string	Can be one of all, public, or private. Default: all
     
     2.affiliation	string	Comma-separated list of values. Can include:
     * owner: Repositories that are owned by the authenticated user.
     * collaborator: Repositories that the user has been added to as a collaborator.
     * organization_member: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
     Default:   owner,collaborator,organization_member
     
     3.type           string	Can be one of all, owner, public, private, member. Default: all
     Will cause a 422 error if used in the same request as visibility or affiliation.
     
     4.sort           string	Can be one of created, updated, pushed, full_name. Default: full_name
     
     5.direction      string	Can be one of asc or desc. Default: when using full_name: asc; otherwise desc
 */
    
    let username = UserLogin.sharedInstance.username
    let password = UserLogin.sharedInstance.password
    let user_pass = "\(unwrap(username)):\(unwrap(password))"
    let utf8str = user_pass.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let header = ["Authorization": "Basic \(base64Encoded!)"]
    
    do {
        let url = try "https://api.github.com/user/repos".asURL()
        request(url: url, parameters: parameters, header: header, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserRepository(_ parameters: inout [String: Any]?,
                                completionHandler: @escaping (Result<Any>) -> Void) -> Void
{
    /*
     1.type         string	Can be one of all, owner, member. Default: owner
     2.sort         string	Can be one of created, updated, pushed, full_name. Default: full_name
     3.direction	string	Can be one of asc or desc. Default: when using full_name: asc, otherwise desc
     */
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/repos".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestRepositoryDetailByUrl(urlString: String?,
                           completionHandler: @escaping (Result<Any>) -> Void) -> Void
{
    /*
     1.type         string	Can be one of all, owner, member. Default: owner
     2.sort         string	Can be one of created, updated, pushed, full_name. Default: full_name
     3.direction	string	Can be one of asc or desc. Default: when using full_name: asc, otherwise desc
     */
    
    do {
        let url = try urlString?.asURL()
        request(url: url!, parameters: nil, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestRepositoryReadme(_ parameters: inout [String: Any]?,
                             completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let owner = parameters!["owner"]
    let repo = parameters!["repo"]
    
    do {
        let url = try "https://api.github.com/repos/\(unwrap(owner))/\(unwrap(repo))/readme".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
    
}


func requestFileRaw(_ url: String,
                        completionHandler: @escaping (Result<Any>) -> Void) {
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    Alamofire.request(url, method: .get)
        .responseData(completionHandler: { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let error = response.result.error {
                log.error("Error: \(error)")
                completionHandler(.Failure(.Error))
            }
            
            if let data = response.result.value {
                completionHandler(.Success(data))
            }
        })
    
}


func requestCodeBranches(_ parameters: inout [String: Any]?,
                         completionHandler: @escaping (Result<Any>) -> Void) -> Void {

    let owner = parameters!["owner"]
    let repo = parameters!["repo"]
    
    do {
        let url = try "https://api.github.com/repos/\(unwrap(owner))/\(unwrap(repo))/branches".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestFileTree(_ parameters: inout [String: Any]?,
                           completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let owner = parameters!["owner"]
    let repo = parameters!["repo"]
    let sha = parameters!["sha"]
    
    do {
        let url = try "https://api.github.com/repos/\(unwrap(owner))/\(unwrap(repo))/git/trees/\(unwrap(sha))".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestFileContent(_ parameters: inout [String: Any]?,
                              completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let owner = parameters!["owner"]
    let repo = parameters!["repo"]
    let path = parameters!["path"]
    
    do {
        let url = try "https://api.github.com/repos/\(unwrap(owner))/\(unwrap(repo))/contents/\(unwrap(path))".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserOrganization(_ parameters: inout [String: Any]?,
                            completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/orgs".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestOrganizationDetail(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let org = parameters!["org"]
    
    do {
        let url = try "https://api.github.com/orgs/\(unwrap(org))".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserInfo(_ parameters: inout [String: Any]?,
                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserStarredRepository(_ parameters: inout [String: Any]?,
                                  completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/starred".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserFollowers(_ parameters: inout [String: Any]?,
                                completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/followers".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUserFollowing(_ parameters: inout [String: Any]?,
                                completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/following".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestIsFollowingUser(_ parameters: inout [String: AnyObject]?,
                                  completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    let targetUser = parameters!["target_user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/following/\(unwrap(targetUser))".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
    /*
     if let statusCode = response.response?.statusCode {
     if (statusCode == 204)
     {
     completionHandler(true)
     }
     else if (statusCode == 404)
     {
     completionHandler(false)
     }
     }
 */
}

func requestUserPublicActivity(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(user))/events/public".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestMyActivity(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    do {
        let url = try "https://api.github.com/users/\(unwrap(UserLogin.sharedInstance.username))/received_events".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}


func requestIssueInRepository(_ parameters: inout [String: Any]?,
                             completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let user = parameters!["user"]
    let repo = parameters!["repo"]
    
    do {
        let url = try "https://api.github.com/repos/\(unwrap(user))/\(unwrap(repo))/issues".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestRepositoryInOrganization(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let org = parameters!["org"]
    
    do {
        let url = try "https://api.github.com/orgs/\(unwrap(org))/repos".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestMembersInOrganization(_ parameters: inout [String: Any]?,
                                           completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let org = parameters!["org"]
    
    do {
        let url = try "https://api.github.com/orgs/\(unwrap(org))/members".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestSearchRepositories(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    do {
        let url = try "https://api.github.com/search/repositories".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestSearchCode(_ parameters: inout [String: Any]?,
                                     completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    do {
        let url = try "https://api.github.com/search/code".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestSearchIssues(_ parameters: inout [String: Any]?,
                               completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    do {
        let url = try "https://api.github.com/search/issues".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestSearchUsers(_ parameters: inout [String: Any]?,
                               completionHandler: @escaping (Result<Any>) -> Void) -> Void {

    do {
        let url = try "https://api.github.com/search/users".asURL()
        request(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestMarkDown(_ text: String,
                        completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let url = "https://api.github.com/markdown"
    
    let param = ["text": text,
                 "mode": "markdown",
                 "context": "github/gollum"]
    
    Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        .responseData(completionHandler: { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let data = response.result.value,
                let utf8Text = String(data: data, encoding: .utf8) {
                log.info("Data: \(utf8Text)")
                completionHandler(.Success(utf8Text))
            }
            
            if let error = response.result.error {
                log.error("Error: \(error)")
                completionHandler(.Failure(.Error))
            }
        })
}

func requestIsStarRepository(_ parameters: inout [String: Any]?,
                             completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let username = UserLogin.sharedInstance.username
    let password = UserLogin.sharedInstance.password
    let user_pass = "\(unwrap(username)):\(unwrap(password))"
    let utf8str = user_pass.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let header = ["Authorization": "Basic \(base64Encoded!)"]
    
    do {
        let owner = parameters!["owner"]
        let repo = parameters!["repo"]
        let url = try "https://api.github.com/user/starred/\(unwrap(owner))/\(unwrap(repo))".asURL()
        request(url: url, parameters: nil, header: header, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestStarRepository(_ parameters: inout [String: Any]?,
                           completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let username = UserLogin.sharedInstance.username
    let password = UserLogin.sharedInstance.password
    let user_pass = "\(unwrap(username)):\(unwrap(password))"
    let utf8str = user_pass.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let header = ["Authorization": "Basic \(base64Encoded!)"]
    
    do {
        let owner = parameters!["owner"]
        let repo = parameters!["repo"]
        let url = try "https://api.github.com/user/starred/\(unwrap(owner))/\(unwrap(repo))".asURL()
        request(method: .put, url: url, parameters: nil, header: header, completionHandler: completionHandler)
    }
    catch {
        
    }
}

func requestUnstarRepository(_ parameters: inout [String: Any]?,
                           completionHandler: @escaping (Result<Any>) -> Void) -> Void {
    
    let username = UserLogin.sharedInstance.username
    let password = UserLogin.sharedInstance.password
    let user_pass = "\(unwrap(username)):\(unwrap(password))"
    let utf8str = user_pass.data(using: String.Encoding.utf8)
    let base64Encoded = utf8str?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    let header = ["Authorization": "Basic \(base64Encoded!)"]
    
    do {
        let owner = parameters!["owner"]
        let repo = parameters!["repo"]
        let url = try "https://api.github.com/user/starred/\(unwrap(owner))/\(unwrap(repo))".asURL()
        request(method: .delete, url: url, parameters: nil, header: header, completionHandler: completionHandler)
    }
    catch {
        
    }
}


