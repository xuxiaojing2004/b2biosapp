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
    var privateMessage : PrivateMessage?
    
    @IBOutlet var messageTableView: UITableView!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("enter the display message page for \(id!)")
        do {
            if id != nil {
                try privateMessageService.getById(id: id!) { (result) in
                    self.privateMessage = result
                    print("message: \(self.privateMessage)")
                    ////self.senderLabel.text = privateMessage?.sender
                    //self.subjectLabel.text = privateMessage?.subject
                    //self.newsWebView.loadHTMLString((publicNotice?.content)!, baseURL: nil)
                    self.messageTableView?.reloadData()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.privateMessage == nil {
            return 0
        } else {
            return 3
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 2 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "privateMessageContentViewCell", for: indexPath) as! PrivateMessageContentViewCell
            if self.privateMessage != nil {
        cell.contentWebView?.loadHTMLString((self.privateMessage?.message)!, baseURL: nil)
            }
        return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "privateMessageViewCell", for: indexPath) as! PrivateMessageViewCell
        
        // Configure the cell...
        if self.privateMessage != nil {

        cell.senderLabel?.text  = self.privateMessage?.sender
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
