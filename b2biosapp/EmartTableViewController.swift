//
//  EmartViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/9/17.
//  Copyright © 2017 jikesai. All rights reserved.
//
import UIKit

import Alamofire
import SwiftyJSON

class EmartTableViewController: UITableViewController {
    
    let emartMaterialTypeService: EmartMaterialTypeService = EmartMaterialTypeServiceImpl();
    
    var emartMaterialTypes : Array<EmartMaterialTypeModel>? = Array<EmartMaterialTypeModel>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try emartMaterialTypes = emartMaterialTypeService.getAll();
        }  catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
        // return the number of rows
        print("row count \(emartMaterialTypes!.count)")

        return emartMaterialTypes!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emartMaterialTypeCell", for: indexPath)
     
        // Configure the cell...
        let emartMaterialType = emartMaterialTypes![indexPath.row]
        
        //cell.emartMatailerialTypeLabel?.text = "\(emartMaterialType.text)"
        cell.textLabel?.text = "\(emartMaterialType.text)"
        cell.detailTextLabel?.text = "\(emartMaterialType.hint!)"
        

        return cell
    }
    
}
