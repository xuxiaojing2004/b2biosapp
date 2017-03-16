//
//  FirstViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/8/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import CoreData

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*Alamofire.NSURLRequest.description();
        */
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let jsonResultString = response.result.value {
                let vendorProduct = VendorProduct(context: managedContext)
                vendorProduct.id = 1
                vendorProduct.uuid  =  UUID().uuidString
                let json = JSON(jsonResultString)
                vendorProduct.json  = json.rawString()
                vendorProduct.status = 1
                
                do {
                    try managedContext.save()
                
                    let vpService: VendorProductService  = VendorProductServiceImpl();
                    let vps: [VendorProduct]? = try vpService.getAll();
                
                    //let fecthRequest: NSFetchRequest<VendorProduct> = VendorProduct.fetchRequest()
                
                    //let vendorProducts =  try managedContext.fetch(fecthRequest)
                    //print ("vendorProduct count:\(vendorProducts.count)")
                
                    for  vp in vps! {
                        if let jsonStr = vp.json {
                            print("vendorProduct json: \(jsonStr)")
                        }
                    }
                
                    let vp : VendorProduct? = try vpService.getByKey(key: "aaaaa")
                    if let jsonStr = vp?.json {
                        print("find vendorProduct by key json: \(jsonStr)")
                    }
                
                    try vpService.deleteAll()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }

                
                print("JSON: \(jsonResultString)")
                
                if let host = json["headers"]["Host"].string {
                    //Now you got your value
                    print("Host:\(host)")
                }

            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

