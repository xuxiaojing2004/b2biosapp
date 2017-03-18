//
//  NewsTableViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/13/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let publicNoticeService : PublicNoticeSevice = PublicNoticeServiceImpl();
    
    var publicNotices : Array<PublicNotice>? = Array<PublicNotice>()
    
    var myGroup = DispatchGroup()

    var curPos = 0;
    let length = 20;

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataModel = JQDataTableModel()
        dataModel.iDisplayStart = String(curPos);
        dataModel.iDisplayLength = String(length);
        
        myGroup.enter()
        do {
            try publicNotices = publicNoticeService.getByPage(dataModel: dataModel)
             self.myGroup.leave()
        }   catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
             myGroup.leave()
        }
        
        self.myGroup.notify(queue: DispatchQueue.main, execute: {
            print("public notice load completed")
        })
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return the number of rows
        return 10//self.publicNotices!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        // Configure the cell...

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
