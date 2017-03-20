//
//  NewsTableViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/13/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let publicNoticeService : PublicNoticeSevice = PublicNoticeServiceImpl();
    
    var publicNotices : Array<PublicNotice>? = Array<PublicNotice>()
    
    var curPos = 0;
    let length = 20;

    override func viewDidLoad() {
        super.viewDidLoad()

        print("loading public notice data")
        let dataModel = JQDataTableModel()
        dataModel.iDisplayStart = String(curPos);
        dataModel.iDisplayLength = String(length);
        
        do {
            //try publicNotices = publicNoticeService.getByPage(dataModel: dataModel)
            try publicNoticeService.getPublicNoticeFromRemote(dataModel: dataModel) { (result) in
                self.publicNotices = result
                print("retrieved publicNotice count \(self.publicNotices!.count)")
                self.newsTableView?.reloadData()
                
            }
        }   catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
       
        //to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "锦江新闻"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNewsDetails" {
            
            let detailViewController = segue.destination
                as! NewsDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let curNews = publicNotices?[row]
            print ("news in row \(row) with id \(curNews?.uuid)! is selected")
            detailViewController.newsUuid = curNews?.uuid
            
            //print("hidesBackButton?=\(detailViewController.navigationItem.hidesBackButton)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if self.publicNotices == nil {
            print("no public notice loaded into the table")
            return 0
        } else {
            print("count of public Notice \(self.publicNotices!.count)")
            return self.publicNotices!.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        // Configure the cell...
        if let publicNotice = publicNotices?[indexPath.row] {
            
            cell.textLabel?.text = publicNotice.subject!
            if let summary = publicNotice.summary {
                cell.detailTextLabel?.text = summary
            } else {
                cell.detailTextLabel?.text = "";
            }
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
