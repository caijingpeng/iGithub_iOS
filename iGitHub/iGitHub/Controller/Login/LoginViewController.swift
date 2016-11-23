//
//  LoginViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/8/29.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.applicationDarkBlueColor
        
        self.loginButton.layer.cornerRadius = 3
        self.loginButton.layer.borderColor = UIColor.applicationLightBlueColor.cgColor
        self.loginButton.layer.borderWidth = applicationLineHeight
        self.loginButton.titleLabel?.font = UIFont.applicationTitleFont
        
        self.loginButton.setBackgroundImage(imageWithColor(UIColor.applicationDarkBlueColor), for: UIControlState())
        self.loginButton.setBackgroundImage(imageWithColor(UIColor.applicationLightBlueColor), for: .highlighted)
        
        self.usernameTF.drawBottomLine(color: UIColor.applicationLightBlueColor)
        self.passwordTF.drawBottomLine(color: UIColor.applicationLightBlueColor)
        
        usernameTF.text = "caijingpeng"
        passwordTF.text = "cjp41846118"
    }
    
    @IBAction func toLogin(_ sender: AnyObject) {
        
        guard checkValue(value: usernameTF.text, message: "请输入账号") else { return }
        guard checkValue(value: passwordTF.text, message: "请输入密码") else { return }
        
        var param : [String: Any]? = ["username" : usernameTF.text!,
                                      "password" : passwordTF.text!]
        
        requestloginUser(&param) { (response) in
            
            guard response.error == nil else {
                showToastInWindow(message: (response.error?.description)!)
                return
            }
            
            if let result: Dictionary<String, Any> = response.value as! Dictionary<String, Any>? {
                let user = UserInfo(dictionary: result as Dictionary<String, AnyObject>)
                UserLogin.sharedInstance.username = self.usernameTF.text
                UserLogin.sharedInstance.password = self.passwordTF.text
                UserLogin.sharedInstance.userInfo = user
                
                let appDel = UIApplication.shared.delegate as! AppDelegate
                appDel.loginVC.view.isHidden = true
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LoginSuccessNotification"), object: nil)
            }
            else {
                log.error("返回数据格式错误 \(response.value)")
            }
            
        }
    }
    
    @IBAction func toTap(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
