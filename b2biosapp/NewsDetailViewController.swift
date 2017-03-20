//
//  NewsViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/18/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    let publicNoticeService : PublicNoticeSevice = PublicNoticeServiceImpl();
    
    var newsUuid: String?

    @IBOutlet weak var newsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("enter the display news page for \(newsUuid!)")
        do {
            //try publicNotices = publicNoticeService.getByPage(dataModel: dataModel)
            if newsUuid != nil {
                try publicNoticeService.getByKey(key: newsUuid!) { (result) in
                    let publicNotice = result
                    self.newsWebView.loadHTMLString((publicNotice?.content)!, baseURL: nil)
                
                }
            }
        }   catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
