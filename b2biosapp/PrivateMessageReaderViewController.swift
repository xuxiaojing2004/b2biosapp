//
//  PrivateMessageReaderTableViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/24/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class PrivateMessageReaderViewController: UITableViewController {
    
    let privateMessageService : PrivateMessageService = PrivateMessageServiceImpl();

    var id: Int?
    
    @IBOutlet var messageTableView: UITableView!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet weak var contentWebView: UIWebView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("enter the display message page for \(id!)")
        do {
            if id != nil {
                try privateMessageService.getById(id: id!) { (result) in
                    let privateMessage = result
                    print("message: \(privateMessage)")
                    
                    self.senderLabel.text = privateMessage?.sender
                    self.timeLabel.text = privateMessage?.sendTime
                    
                    self.subjectLabel.text = privateMessage?.subject
                    
                    self.contentWebView.loadHTMLString((privateMessage?.message)!, baseURL: nil)
                    
                    if let hasRead = privateMessage?.hasRead {
                        // Define attributes
                        let labelFont = UIFont(name: "HelveticaNeue-Bold", size: 14)
                        let attributes :Dictionary = [NSFontAttributeName : labelFont]
                        
                        // Create attributed string
                        var attrString = NSAttributedString(string: (privateMessage?.subject!)!, attributes:attributes)
                        self.subjectLabel.attributedText = attrString
                        //self.subjectLabel.toggleBoldface(self)
                    }
                }
            }
        }   catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
