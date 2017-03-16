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
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    let keyStoreService: KeyStoreService = KeyStoreServiceImpl();
    
    var emartMaterialTypes = Array<EmartMaterialTypeModel>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshEmartMaterialTypes()
        
    }
    
    private func refreshEmartMaterialTypes() {
        
        do {
            var json : JSON = nil
            var keyStore : KeyStore? = try keyStoreService.getByKey(key: Constants.KEY_EMART_MATERIAL_TYPE);
            
            if keyStore == nil || isExpired(keyStore: keyStore!) {
                if (keyStore == nil) {
                    print("create emart material type")
                    keyStore = KeyStore(context: self.managedContext)
                    keyStore?.key = Constants.KEY_EMART_MATERIAL_TYPE
                }
                
                Alamofire.request(Constants.GET_EMART_MATERIAL_TYPE_URL).responseJSON { response in
                    if let jsonResultString = response.result.value {
                        print("Emart material type JSON: \(jsonResultString)")
                        json = JSON(jsonResultString)
                        
                        keyStore?.json  = json.rawString()
                        keyStore?.status = 1

                        do {
                            try self.keyStoreService.save(keyStore: keyStore!)
                        }  catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                        self.populateMaterialTypeJson(json: json)
                    }
                }
            } else {
                //print("Find keyStore from DB: \(keyStore); json: \(keyStore?.json!)")
                let jsonStr = keyStore!.json!
                print("json from db \(jsonStr)")
                if let data = jsonStr.data(using: String.Encoding.utf8) {
                    let json = JSON(data: data)
                    self.populateMaterialTypeJson(json: json)
                }
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    private func populateMaterialTypeJson(json: JSON) -> Array<EmartMaterialTypeModel> {
    
        if let action = json["action"].string {
            if action == "ok" {
                let mtTypeList: Array<JSON> = json["data"].arrayValue
                for mtType in mtTypeList{
                    let emartMaterialType = EmartMaterialTypeModel()
                    emartMaterialType.id = mtType["id"].intValue
                    emartMaterialType.text  = (mtType["text"].string)!
                    emartMaterialType.hint = mtType["hint"].string
                    emartMaterialType.count = mtType["count"].intValue
                    emartMaterialTypes.append(emartMaterialType)
                }
            }
        //Now you got your value
            print("Action:\(action) count \(emartMaterialTypes.count)")
        
        }
        return emartMaterialTypes
    }
    
    private func isExpired(keyStore: KeyStore) -> Bool {
        return false;
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
        print("row count \(emartMaterialTypes.count)")

        return emartMaterialTypes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emartMaterialTypeCell", for: indexPath)
     
        // Configure the cell...
        let emartMaterialType = emartMaterialTypes[indexPath.row]
        
        //cell.emartMatailerialTypeLabel?.text = "\(emartMaterialType.text)"
        cell.textLabel?.text = "\(emartMaterialType.text)"
        cell.detailTextLabel?.text = "\(emartMaterialType.hint!)"

        return cell
    }
    
}
