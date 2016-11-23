//
//  WebBrowserViewController.swift
//  iGitHub
//
//  Created by caijingpeng on 16/9/13.
//  Copyright © 2016年 caijingpeng. All rights reserved.
//

import UIKit

class WebBrowserViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    var htmlUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.htmlUrl
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Share"), style: .plain, target: self, action: #selector(WebBrowserViewController.toShare))
        
        if let url = self.htmlUrl {
            self.webView.loadRequest(URLRequest(url: URL(string: url)!))
        }
    }
    
    func toShare() {
        
        let excludedActivities = [UIActivityType.assignToContact,
                                  UIActivityType.saveToCameraRoll];
//        let starActivity = StarActivity()
        
        let shareObj = URL(string: self.htmlUrl!)
        
        let controller = UIActivityViewController(activityItems: [shareObj!], applicationActivities: [])
        controller.excludedActivityTypes = excludedActivities;
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { (type, complete, item, error) in
            print("\(type) \(complete) \(item) \(error)")
        }
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
