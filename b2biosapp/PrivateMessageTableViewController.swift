//
//  MessageViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/9/17.
//  Copyright © 2017 jikesai. All rights reserved.
//
import UIKit

class PrivateMessageTableViewController: UITableViewController {
    
    let privateMessageService : PrivateMessageService = PrivateMessageServiceImpl();
    
    var privateMessages : Array<PrivateMessage>? = Array<PrivateMessage>()
    
    var curPos = 0;
    let length = 20;
    
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("loading pprivate message data")
        let dataModel = JQDataTableModel()
        dataModel.iDisplayStart = String(curPos);
        dataModel.iDisplayLength = String(length);
        
        do {
            //try publicNotices = publicNoticeService.getByPage(dataModel: dataModel)
            try privateMessageService.getPrivateMessageFromRemote(dataModel: dataModel) { (result) in
                self.privateMessages = result
                print("retrieved privateMessage count \(self.privateMessages!.count)")
                self.messageTableView?.reloadData()
                
            }
        }   catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "邮件消息"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("current segue is \(segue.identifier)")
        if segue.identifier == "ShowPrivateMessage" {
            
            let messageViewController = segue.destination
                as! PrivateMessageReaderViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let message = privateMessages?[row]
            print ("message in row \(row) with id \((message?.id)!) is selected")
            messageViewController.id = Int((message?.id)!)
            
            //print("hidesBackButton?=\(detailViewController.navigationItem.hidesBackButton)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if self.privateMessages == nil {
            print("no private message loaded into the table")
            return 0
        } else {
            print("count of private message \(self.privateMessages!.count)")
            return self.privateMessages!.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "privateMessageCell", for: indexPath) as! PrivateMessageTableViewCell
        
        // Configure the cell...
        if let message = privateMessages?[indexPath.row] {
            
            cell.senderLabel?.text  = message.sender
            cell.subjectLabel?.text = message.subject
            cell.timeLabel?.text = message.sendTime
            
        }
        return cell
    }
    
}
